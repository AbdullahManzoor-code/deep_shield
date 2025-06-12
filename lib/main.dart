import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'screens/file_selection_screen.dart';
import 'screens/audio_selection_screen.dart';
import 'screens/results_screen.dart';
import 'services/audio_prediction_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DeepShieldApp());
}

class DeepShieldApp extends StatelessWidget {
  const DeepShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Shield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
      routes: {
        '/results': (context) => const ResultsScreen(
          selectedFile: 'Audio.mp3', 
          result: 'Detection completed successfully!'
        ),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _selectedFile;
  String? _selectedFilePath;
  bool _isDetecting = false;
  String _detectionResult = '';

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav', 'mp3', 'aac', 'm4a'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  void _selectPreloadedFile(String fileName) {
    setState(() {
      _selectedFile = fileName;
      _selectedFilePath = null; // Indicates it's a preloaded file
    });
  }

  void _startDetection() async {
    if (_selectedFile == null) return;
    
    setState(() {
      _isDetecting = true;
    });
    
    String result;
    
    if (_selectedFilePath != null) {
      // User selected file - use real API prediction
      try {
        File audioFile = File(_selectedFilePath!);
        result = await AudioPredictionService.predictAudio(audioFile);
      } catch (e) {
        result = 'Error processing audio file: $e';
      }
    } else {
      // Preloaded file - simulate detection for demo purposes
      await Future.delayed(const Duration(seconds: 3));
      
      final detectionResults = [
        'REAL VOICE DETECTED\n✅ Authenticity: 94.7%\n🔊 Voice Analysis: Natural speech patterns\n⚡ Confidence: High',
        'DEEPFAKE DETECTED\n⚠️ Authenticity: 23.1%\n🤖 AI Generated: High probability\n🔍 Artifacts found in frequency analysis',
        'REAL VOICE DETECTED\n✅ Authenticity: 87.3%\n🔊 Voice Analysis: Human vocal characteristics\n⚡ Confidence: Medium-High',
      ];
      
      result = detectionResults[DateTime.now().millisecond % detectionResults.length];
    }
    
    setState(() {
      _isDetecting = false;
      _detectionResult = result;
    });

    // Navigate to results screen
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            selectedFile: _selectedFile!,
            result: _detectionResult,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FileSelectionScreen(
      onFileSelect: _selectFile,
      onStartDetection: _startDetection,
      selectedFile: _selectedFile,
      isDetecting: _isDetecting,
    );
  }
}

// Wrapper classes for navigation with state
// class AudioSelectionScreenWrapper extends StatefulWidget {
//   const AudioSelectionScreenWrapper({super.key});

//   @override
//   State<AudioSelectionScreenWrapper> createState() => _AudioSelectionScreenWrapperState();
// }

// class _AudioSelectionScreenWrapperState extends State<AudioSelectionScreenWrapper> {
//   String? _selectedFile;
//   bool _isDetecting = false;

//   void _selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.audio,
//       allowMultiple: false,
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.single.name;
//       });
//     }
//   }

//   void _startDetection() {
//     setState(() {
//       _isDetecting = true;
//     });
    
//     // Simulate detection process
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isDetecting = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AudioSelectionScreen(
//       onFileSelect: _selectFile,
//       onStartDetection: _startDetection,
//       selectedFile: _selectedFile ?? 'Audio.mp3',
//       isDetecting: _isDetecting,
//     );
//   }
// }

class ResultsScreenWrapper extends StatelessWidget {
  const ResultsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResultsScreen(
      selectedFile: 'Audio.mp3',
      result: 'Result of your voice is here !',
    );
  }
}
