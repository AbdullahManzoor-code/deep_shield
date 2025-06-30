import 'package:audioplayers/audioplayers.dart';
import 'package:deep_shield/screens/file_selection_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import '../utils/responsive_utils.dart';

class ResultsScreen extends StatefulWidget {
  final File file;
  final String result;

  const ResultsScreen({
    super.key,
    required this.file,
    required this.result,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isAudioError = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    setState(() { _isAudioError = false; });
    try {
      debugPrint('Trying to play: \\${widget.file.path}');
      final file = widget.file;
      final exists = await file.exists();
      debugPrint('File exists: \\${exists}');
      if (!exists) {
        setState(() { _isAudioError = true; _isPlaying = false; });
        return;
      }
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.setSource(DeviceFileSource(file.path));
        await _audioPlayer.resume();
        setState(() => _isPlaying = true);
        _audioPlayer.onPlayerComplete.listen((event) {
          setState(() => _isPlaying = false);
        });
      }
    } catch (e) {
      debugPrint('AudioPlayer error: \\${e}');
      setState(() { _isAudioError = true; _isPlaying = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom;
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
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
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: context.maxContentWidth * 0.8,
                    ),
                    padding: context.cardPadding,
                    margin: EdgeInsets.only(top: 8, bottom: context.getSpacing(1.2)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade600,
                          Colors.deepPurple.shade800,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
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
                  // Audio File Info with audio player progress bar
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
                        Text(
                          p.basename(widget.file.path),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: context.bodyFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.getSpacing(0.8)),
                        // Audio Player Progress Bar and Play/Pause
                     ModernAudioPlayerBar(
                          audioPlayer: _audioPlayer,
                          file: widget.file,
                          isPlaying: _isPlaying,
                          isAudioError: _isAudioError,
                          onPlayPause: _togglePlayPause,
                        ),
                      ],
                    ),
                  ),
                  // Results Section
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
                              if (widget.result.isEmpty) ...[
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
                                  widget.result,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: context.subtitleFontSize,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: context.maxContentWidth * 0.7,
                    ),
                    child: Column(
                      children: [
                        // // Back Button
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: context.buttonHeight,
                        //   child: ElevatedButton(
                        //     onPressed: () => Navigator.pop(context),
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.transparent,
                        //       foregroundColor: Colors.white,
                        //       side: BorderSide(
                        //         color: Colors.white.withOpacity(0.3),
                        //         width: 2,
                        //       ),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(context.borderRadius),
                        //       ),
                        //       elevation: 0,
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Icon(Icons.arrow_back),
                        //         SizedBox(width: context.getSpacing(0.3)),
                        //         Text(
                        //           'Back to Selection',
                        //           style: TextStyle(
                        //             fontSize: context.bodyFontSize + 2,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: context.getSpacing(0.5)),
                        // New Analysis Button
                        SizedBox(
                          width: double.infinity,
                          height: context.buttonHeight + 10,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                            icon: Icon(
                              Icons.replay_rounded,
                              size: context.iconSize + 4,
                            ),
                            label: Text(
                              'Start New Detection',
                              style: TextStyle(
                                fontSize: context.subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(context.borderRadius),
                              ),
                              elevation: 12,
                              shadowColor: Colors.green.withOpacity(0.5),
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
      ),
    );
  }
}

// Add this widget to the file (at the bottom):

class _AudioPlayerBar extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final File file;
  final bool isPlaying;
  final bool isAudioError;
  final VoidCallback onPlayPause;

  const _AudioPlayerBar({
    required this.audioPlayer,
    required this.file,
    required this.isPlaying,
    required this.isAudioError,
    required this.onPlayPause,
  });

  @override
  State<_AudioPlayerBar> createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends State<_AudioPlayerBar> {
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget.audioPlayer;
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _position.inMilliseconds.toDouble().clamp(0, _duration.inMilliseconds.toDouble()),
          min: 0,
          max: _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1,
          onChanged: (value) async {
            await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
          },
          activeColor: Colors.greenAccent,
          inactiveColor: Colors.white24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                widget.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                color: Colors.greenAccent,
                size: context.iconSize + 10,
              ),
              onPressed: widget.onPlayPause,
              tooltip: widget.isPlaying ? 'Pause' : 'Play',
            ),
            SizedBox(width: 8),
            Text(
              _formatDuration(_position),
              style: TextStyle(color: Colors.white, fontSize: context.bodyFontSize - 2),
            ),
            Text(' / ', style: TextStyle(color: Colors.white54)),
            Text(
              _formatDuration(_duration),
              style: TextStyle(color: Colors.white, fontSize: context.bodyFontSize - 2),
            ),
          ],
        ),
        if (widget.isAudioError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Could not play audio file.',
              style: TextStyle(color: Colors.red[200], fontSize: context.bodyFontSize),
            ),
          ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
