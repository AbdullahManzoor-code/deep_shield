import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../utils/responsive_utils.dart';

class FileSelectionScreen extends StatefulWidget {
  final VoidCallback onFileSelect;
  final VoidCallback onStartDetection;
  final File? file;
  final bool isDetecting;

  const FileSelectionScreen({
    super.key,
    required this.onFileSelect,
    required this.onStartDetection,
    required this.file,
    required this.isDetecting,
  });

  @override
  State<FileSelectionScreen> createState() => _FileSelectionScreenState();
}

class _FileSelectionScreenState extends State<FileSelectionScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isAudioError = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (widget.file == null) return;
    setState(() { _isAudioError = false; });
    try {
      debugPrint('Trying to play: \\${widget.file!.path}');
      final file = widget.file!;
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
    // Calculate heights for each section based on available screen height
    final headerHeight = screenHeight * 0.08;
    final logoHeight = screenHeight * 0.18;
    final infoCardHeight = screenHeight * 0.13;
    final fileCardHeight = screenHeight * 0.32;
    final spacing = screenHeight * 0.02;

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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          height: headerHeight,
                          constraints: BoxConstraints(
                            maxWidth: context.maxContentWidth * 0.8,
                          ),
                          padding: context.cardPadding,
                          margin: EdgeInsets.only(top: 8, bottom: spacing * 0.5),
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
                                  fontSize: context.titleFontSize-2,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Logo Section
                        SizedBox(
                          height: logoHeight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: logoHeight,
                                height: logoHeight,
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
                                  child: ClipOval(
                                    child: Image.asset(
                                      'asset/logo.png',
                                      width: logoHeight - 16,
                                      height: logoHeight - 16,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.security,
                                          size: logoHeight * 0.4,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.isDetecting)
                                SizedBox(
                                  width: logoHeight,
                                  height: logoHeight,
                                  child: CircularProgressIndicator(
                                    color: Colors.cyan,
                                    strokeWidth:5,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // SizedBox(height: spacing * 0.7),
                        // Info Card as Expandable Button
                        SizedBox(height: spacing * 0.7),
                        // File Selection Card
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
                        ExpandableInfoCard(),
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
                          widget.file != null ? p.basename(widget.file!.path) : 'No file selected',
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
                          file: widget.file ?? File(''), // Provide a dummy file if null, or handle in widget
                          isPlaying: _isPlaying,
                          isAudioError: _isAudioError,
                          onPlayPause: _togglePlayPause,
                        ),
                                                      SizedBox(height: context.getSpacing(0.5)),

                           // File Selection Button
                              SizedBox(
                                width: double.infinity,
                                height: context.buttonHeight,
                                child: ElevatedButton.icon(
                                  onPressed: widget.onFileSelect,
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
                       ],
                    ),
                  ),
                ),

                // Detection Button fixed at the bottom
                Padding(
                  padding: EdgeInsets.only(top: spacing, bottom: context.getSpacing(1)),
                  child: SizedBox(
                    width: double.infinity,
                    height: context.buttonHeight + 10,
                    child: ElevatedButton.icon(
                      onPressed: widget.file != null
                          ? widget.onStartDetection 
                          : null,
                      icon: widget.isDetecting
                          ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Icon(
                              Icons.play_circle_filled_rounded, 
                              size: context.iconSize + 6,
                            ),
                      label: Text(
                        widget.isDetecting ? 'Analyzing...' : 'Start Detection',
                        style: TextStyle(
                          fontSize: context.subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.borderRadius * 1.2),
                        ),
                        elevation: 16,
                        shadowColor: Colors.green.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
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

class ModernAudioPlayerBar extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final File file;
  final bool isPlaying;
  final bool isAudioError;
  final VoidCallback onPlayPause;

  const ModernAudioPlayerBar({
    required this.audioPlayer,
    required this.file,
    required this.isPlaying,
    required this.isAudioError,
    required this.onPlayPause,
  });

  @override
  State<ModernAudioPlayerBar> createState() => ModernAudioPlayerBarState();
}

class ModernAudioPlayerBarState extends State<ModernAudioPlayerBar> {
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
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: Icon(
                widget.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
              onPressed: widget.onPlayPause,
              tooltip: widget.isPlaying ? 'Pause' : 'Play',
            ),
            SizedBox(width: 4),
            Text(
              _formatDuration(_position),
              style: TextStyle(color: Colors.white, fontSize: 14, fontFeatures: [FontFeature.tabularFigures()]),
            ),
            SizedBox(width: 2),
            Text('/', style: TextStyle(color: Colors.white54, fontSize: 14)),
            SizedBox(width: 2),
            Text(
              _formatDuration(_duration),
              style: TextStyle(color: Colors.white, fontSize: 14, fontFeatures: [FontFeature.tabularFigures()]),
            ),
            SizedBox(width: 8),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: Colors.white,
                ),
                child: Slider(
                  value: _position.inMilliseconds.toDouble().clamp(0, _duration.inMilliseconds.toDouble()),
                  min: 0,
                  max: _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1,
                  onChanged: (value) async {
                    await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                  },
                ),
              ),
            ),
            // SizedBox(width: 8),
            // Icon(Icons.volume_up, color: Colors.white, size: 22),
            // SizedBox(width: 8),
            // Icon(Icons.more_vert, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class ExpandableInfoCard extends StatefulWidget {
  @override
  State<ExpandableInfoCard> createState() => _ExpandableInfoCardState();
}

class _ExpandableInfoCardState extends State<ExpandableInfoCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.blue[300]
        : Colors.blue[700];
    final infoText = "Upload an audio file to detect if it's generated by AI or is authentic human speech.";
    return Column(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: IconButton(
            icon: Icon(_expanded ? Icons.info : Icons.info_outline_rounded, color: iconColor, size: 32),
            tooltip: _expanded ? 'Hide Info' : 'Show Info',
            onPressed: () => setState(() => _expanded = !_expanded),
          ),
        ),
        AnimatedCrossFade(
          firstChild: SizedBox.shrink(),
          secondChild: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[900]?.withOpacity(0.15) ?? Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.blue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                // Icon(Icons.info_outline_rounded, color: iconColor),
                // const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    infoText,
                    style: TextStyle(
                      color: Colors.blue[100] ?? Colors.blue,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize ?? 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
