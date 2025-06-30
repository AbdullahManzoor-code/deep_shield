import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'screens/file_selection_screen.dart';
import 'screens/results_screen.dart';
import 'services/audio_prediction_service.dart';

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
        '/results': (context) => ResultsScreen(
          file: File('Audio.mp3'), 
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
  File? _selectedFile;
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
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _startDetection() async {
    if (_selectedFile == null) return;
    
    setState(() {
      _isDetecting = true;
    });
    
    String result;
    
    try {
      result = await AudioPredictionService.predictAudio(_selectedFile!);
    } catch (e) {
      result = 'Error processing audio file: $e';
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
            file: _selectedFile!,
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
      file: _selectedFile,
      isDetecting: _isDetecting,
    );
  }
}

