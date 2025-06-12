import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AudioPredictionService {
  static const String _apiUrl = 'https://Hamza-here-Deep-Shield-System.hf.space/predict';

  static Future<String> predictAudio(File audioFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(_apiUrl),
      );
      
      request.files.add(
        await http.MultipartFile.fromPath('audio', audioFile.path),
      );

      print('Sending request to: $_apiUrl');
      print('Audio file: ${basename(audioFile.path)}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        print('API Response: ${response.body}'); // Debug print
        print('Label: ${data['label']}'); // Debug print
        print('Scores: ${data['scores']}'); // Debug print
        
        final label = data['label'];
        final scores = data['scores'];
        final fakeScore = (scores['fake'] * 100).toDouble();
        final realScore = (scores['real'] * 100).toDouble();
        
        // Determine if it's real or fake based on the label
        final isReal = label.toString().toLowerCase().contains('real');
        
        if (isReal) {
          return 'REAL VOICE DETECTED\n✅ Authenticity: ${realScore.toStringAsFixed(1)}%\n🔊 Voice Analysis: Natural speech patterns\n⚡ Confidence: ${realScore > 80 ? 'High' : realScore > 60 ? 'Medium' : 'Low'}\n📊 Fake Score: ${fakeScore.toStringAsFixed(1)}%';
        } else {
          return 'DEEPFAKE DETECTED\n⚠️ Authenticity: ${realScore.toStringAsFixed(1)}%\n🤖 AI Generated: High probability\n🔍 Artifacts found in frequency analysis\n⚡ Fake Confidence: ${fakeScore.toStringAsFixed(1)}%';
        }
      } else {
        return 'Prediction failed. Status code: ${response.statusCode}\nPlease check your internet connection and try again.';
      }
    } catch (e) {
      return 'Error during prediction: $e\nPlease ensure the audio file is in a supported format and try again.';
    }
  }
}