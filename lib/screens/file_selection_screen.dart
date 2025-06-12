import 'package:flutter/material.dart';

class FileSelectionScreen extends StatelessWidget {
  final VoidCallback onFileSelect;
  final VoidCallback onStartDetection;
  final String? selectedFile;
  final bool isDetecting;

  const FileSelectionScreen({
    super.key,
    required this.onFileSelect,
    required this.onStartDetection,
    this.selectedFile,
    required this.isDetecting,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final logoSize = isTablet ? 200.0 : 160.0;
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Deep Shield',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.05),
                
                // Circular Logo with Gradient
                Container(
                  width: logoSize,
                  height: logoSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF00FFFF), // Cyan
                        Color(0xFF0080FF), // Blue
                        Color(0xFF8A2BE2), // Purple
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 50,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A1A1A),
                    ),
                    child: isDetecting
                        ? const CircularProgressIndicator(
                            color: Colors.cyan,
                            strokeWidth: 3,
                          )
                        : ClipOval(
                            child: Image.asset(
                              'asset/logo.png',
                              width: logoSize - 16,
                              height: logoSize - 16,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.security,
                                  size: 80,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: screenSize.height * 0.08),
                
                // App Title
                Text(
                  'Deepfake Voice Detection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 28 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  'Secure • Accurate • Real-time',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: isTablet ? 18 : 16,
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: screenSize.height * 0.08),
                
                // File Selection Card
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 500 : double.infinity,
                  ),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[800]!.withOpacity(0.8),
                        Colors.grey[900]!.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.audiotrack_rounded,
                        size: isTablet ? 50 : 40,
                        color: Colors.purple[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        selectedFile ?? 'No file selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      // File Selection Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: onFileSelect,
                          icon: const Icon(Icons.folder_open_rounded),
                          label: const Text(
                            'Choose Audio File',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 8,
                            shadowColor: Colors.purple.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: screenSize.height * 0.06),
                
                // Detection Button
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 400 : double.infinity,
                  ),
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: selectedFile != null && !isDetecting 
                        ? onStartDetection 
                        : null,
                    icon: isDetecting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.play_circle_filled_rounded, size: 28),
                    label: Text(
                      isDetecting ? 'Analyzing...' : 'Start Detection',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedFile != null && !isDetecting
                          ? Colors.green[600]
                          : Colors.grey[600],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: selectedFile != null ? 12 : 4,
                      shadowColor: selectedFile != null
                          ? Colors.green.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
                
                SizedBox(height: screenSize.height * 0.04),
                
                // Info Card
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 500 : double.infinity,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[900]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.blue[300],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Upload an audio file to detect if it\'s generated by AI or is authentic human speech.',
                          style: TextStyle(
                            color: Colors.blue[100],
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
