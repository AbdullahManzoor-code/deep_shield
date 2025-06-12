import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class ResultsScreen extends StatelessWidget {
  final String selectedFile;
  final String result;

  const ResultsScreen({
    super.key,
    required this.selectedFile,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.black,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: context.responsivePadding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      children: [
                        // Header with enhanced design
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: context.maxContentWidth * 0.8,
                          ),
                          padding: context.cardPadding,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade600,
                                Colors.deepPurple.shade800,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(context.borderRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security,
                                color: Colors.white,
                                size: context.iconSize + 8,
                              ),
                              SizedBox(width: context.getSpacing(0.5)),
                              Text(
                                'Deep Shield',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: context.getSpacing(1.5)),
                        
                        // Audio File Info with enhanced design
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: context.maxContentWidth * 0.9,
                          ),
                          padding: context.cardPadding * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(context.borderRadius),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.audiotrack,
                                color: Colors.blue.shade300,
                                size: context.iconSize + 16,
                              ),
                              SizedBox(height: context.getSpacing(0.5)),
                              Text(
                                'Audio File',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: context.bodyFontSize + 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: context.getSpacing(0.3)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.getSpacing(0.8),
                                  vertical: context.getSpacing(0.4),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(context.borderRadius * 0.8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        selectedFile,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: context.bodyFontSize + 2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: context.getSpacing(0.5)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.getSpacing(0.4),
                                        vertical: context.getSpacing(0.2),
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade400,
                                            Colors.blue.shade600,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(context.borderRadius * 0.6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.bodyFontSize,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: context.getSpacing(1.5)),
                        
                        // Results Section with enhanced design
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: context.maxContentWidth,
                          ),
                          padding: context.cardPadding,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(context.borderRadius),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    color: Colors.green.shade400,
                                    size: context.iconSize + 4,
                                  ),
                                  SizedBox(width: context.getSpacing(0.5)),
                                  Text(
                                    'Analysis Results',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.subtitleFontSize + 4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: context.getSpacing()),
                              
                              Container(
                                width: double.infinity,
                                padding: context.cardPadding,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.grey.shade100,
                                      Colors.grey.shade200,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(context.borderRadius * 0.8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    if (result.isEmpty) ...[
                                      Icon(
                                        Icons.hourglass_empty,
                                        color: Colors.grey.shade600,
                                        size: context.iconSize + 16,
                                      ),
                                      SizedBox(height: context.getSpacing(0.5)),
                                      Text(
                                        'Analysis Complete',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: context.subtitleFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: context.getSpacing(0.3)),
                                      Text(
                                        'Your voice analysis results will appear here',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: context.bodyFontSize + 2,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        result,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: context.subtitleFontSize,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: context.getSpacing(1.5)),
                        
                        // Action Buttons
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: context.maxContentWidth * 0.7,
                          ),
                          child: Column(
                            children: [
                              // Back Button
                              SizedBox(
                                width: double.infinity,
                                height: context.buttonHeight,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(context.borderRadius),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.arrow_back),
                                      SizedBox(width: context.getSpacing(0.3)),
                                      Text(
                                        'Back to Selection',
                                        style: TextStyle(
                                          fontSize: context.bodyFontSize + 2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: context.getSpacing(0.5)),
                              
                              // New Analysis Button
                              SizedBox(
                                width: double.infinity,
                                height: context.buttonHeight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple.shade600,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(context.borderRadius),
                                    ),
                                    elevation: 8,
                                    shadowColor: Colors.purple.withOpacity(0.4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.refresh),
                                      SizedBox(width: context.getSpacing(0.3)),
                                      Text(
                                        'New Analysis',
                                        style: TextStyle(
                                          fontSize: context.bodyFontSize + 2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
