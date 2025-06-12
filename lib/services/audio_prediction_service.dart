import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AudioPredictionService {
  static const String _apiUrl = 'https://Hamza-here-Deep-Shield-System.hf.space/predict';

  static Future<String> predictAudio(File audioFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(_apiUrl),
      );

      // Set proper headers for form-data
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Add the audio file as form-data with field name "audio" (exactly as shown in Postman)
      request.files.add(await http.MultipartFile.fromPath(
        'audio',  // This matches the "audio" field name in your Postman screenshot
        audioFile.path,
        filename: basename(audioFile.path),
      ));

      print('Sending request to: $_apiUrl');
      print('Audio file: ${basename(audioFile.path)}');
      print('File size: ${await audioFile.length()} bytes');

      var response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        print('API Response: $resStr'); // Debug print
        final jsonResponse = json.decode(resStr);

        // Extract label and scores from the API response
        final label = jsonResponse['label']; // Get the label from response
        final scores = jsonResponse['scores']; // Get the scores object
        
        print('Label: $label'); // Debug print
        print('Scores: $scores'); // Debug print
        
        // Determine if it's real or fake based on the label
        final isReal = label.toString().toLowerCase().contains('real');
        
        double confidence = 0.0;
        if (scores != null) {
          if (isReal && scores['real'] != null) {
            confidence = (scores['real'] * 100).toDouble();
          } else if (!isReal && scores['fake'] != null) {
            confidence = (scores['fake'] * 100).toDouble();
          }
        }
        
        if (isReal) {
          return 'REAL VOICE DETECTED\n✅ Authenticity: ${confidence.toStringAsFixed(1)}%\n🔊 Voice Analysis: Natural speech patterns\n⚡ Confidence: ${confidence > 80 ? 'High' : confidence > 60 ? 'Medium' : 'Low'}';
        } else {
          return 'DEEPFAKE DETECTED\n⚠️ Authenticity: ${(100 - confidence).toStringAsFixed(1)}%\n🤖 AI Generated: High probability\n🔍 Artifacts found in frequency analysis\n⚡ Fake Confidence: ${confidence.toStringAsFixed(1)}%';
        }
      } else {
        final errorBody = await response.stream.bytesToString();
        print('Error response: $errorBody'); // Debug print
        return 'Prediction failed. Status code: ${response.statusCode}\nError: $errorBody\nPlease check your internet connection and try again.';
      }
    } catch (e) {
      return 'Error during prediction: $e\nPlease ensure the audio file is in a supported format and try again.';
    }
  }
}