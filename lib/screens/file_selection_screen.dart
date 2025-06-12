import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Deep Shield',
          style: TextStyle(
            color: Colors.white,
            fontSize: context.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: context.responsivePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.getSpacing(1.5)),
                
                // Circular Logo with Gradient
                Container(
                  width: context.logoSize,
                  height: context.logoSize,
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
                        blurRadius: context.isDesktop ? 40 : 30,
                        spreadRadius: context.isDesktop ? 15 : 10,
                      ),
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: context.isDesktop ? 60 : 50,
                        spreadRadius: context.isDesktop ? 25 : 20,
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.all(context.isDesktop ? 12 : 8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A1A1A),
                    ),
                    child: isDetecting
                        ? CircularProgressIndicator(
                            color: Colors.cyan,
                            strokeWidth: context.isDesktop ? 4 : 3,
                          )
                        : ClipOval(
                            child: Image.asset(
                              'asset/logo.png',
                              width: context.logoSize - 16,
                              height: context.logoSize - 16,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.security,
                                  size: context.logoSize * 0.4,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: context.getSpacing(2)),
                
                // App Title
                Text(
                  'Deepfake Voice Detection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.titleFontSize + 4,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: context.getSpacing(0.5)),
                
                Text(
                  'Secure • Accurate • Real-time',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: context.subtitleFontSize,
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: context.getSpacing(2)),
                
                // File Selection Card
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: context.maxContentWidth * 0.8,
                  ),
                  padding: context.cardPadding,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[800]!.withOpacity(0.8),
                        Colors.grey[900]!.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(context.borderRadius),
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
                        size: context.iconSize + 16,
                        color: Colors.purple[300],
                      ),
                      SizedBox(height: context.getSpacing(0.5)),
                      Text(
                        selectedFile ?? 'No file selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.subtitleFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.getSpacing(0.8)),
                      
                      // File Selection Button
                      SizedBox(
                        width: double.infinity,
                        height: context.buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: onFileSelect,
                          icon: const Icon(Icons.folder_open_rounded),
                          label: Text(
                            'Choose Audio File',
                            style: TextStyle(
                              fontSize: context.bodyFontSize + 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.borderRadius * 0.8),
                            ),
                            elevation: 8,
                            shadowColor: Colors.purple.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: context.getSpacing(1.5)),
                
                // Detection Button
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: context.maxContentWidth * 0.6,
                  ),
                  height: context.buttonHeight + 10,
                  child: ElevatedButton.icon(
                    onPressed: selectedFile != null && !isDetecting 
                        ? onStartDetection 
                        : null,
                    icon: isDetecting
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.play_circle_filled_rounded, 
                            size: context.iconSize + 4,
                          ),
                    label: Text(
                      isDetecting ? 'Analyzing...' : 'Start Detection',
                      style: TextStyle(
                        fontSize: context.subtitleFontSize,
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
                        borderRadius: BorderRadius.circular(context.borderRadius),
                      ),
                      elevation: selectedFile != null ? 12 : 4,
                      shadowColor: selectedFile != null
                          ? Colors.green.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
                
                SizedBox(height: context.getSpacing()),
                
                // Info Card
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: context.maxContentWidth * 0.8,
                  ),
                  padding: EdgeInsets.all(context.isDesktop ? 25 : 20),
                  decoration: BoxDecoration(
                    color: Colors.blue[900]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(context.borderRadius * 0.8),
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
                        size: context.iconSize,
                      ),
                      SizedBox(width: context.getSpacing(0.5)),
                      Expanded(
                        child: Text(
                          'Upload an audio file to detect if it\'s generated by AI or is authentic human speech.',
                          style: TextStyle(
                            color: Colors.blue[100],
                            fontSize: context.bodyFontSize,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: context.getSpacing()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
