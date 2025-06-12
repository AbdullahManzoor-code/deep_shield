import 'package:flutter/material.dart';

class AudioSelectionScreen extends StatelessWidget {
  final VoidCallback onFileSelect;
  final VoidCallback onStartDetection;
  final String selectedFile;
  final bool isDetecting;

  const AudioSelectionScreen({
    super.key,
    required this.onFileSelect,
    required this.onStartDetection,
    required this.selectedFile,
    required this.isDetecting,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Deep Shield',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Circular Detection UI
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Colors.cyan, Colors.blue, Colors.purple],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: isDetecting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Image(
                image: AssetImage('asset/logo.png'),
                fit: BoxFit.cover,
              ),  
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Audio File Selection
            GestureDetector(
              onTap: onFileSelect,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[600]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedFile,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Choose',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Start Detection Button
            ElevatedButton(
              onPressed: !isDetecting ? onStartDetection : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                disabledBackgroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                isDetecting ? 'Detecting...' : 'Start Detection',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            
            const Spacer(),
            
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('File Select', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/file_list'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('File List', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/results'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Results', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
