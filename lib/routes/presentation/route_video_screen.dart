import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:video_player/video_player.dart';

class RouteVideoScreen extends StatefulWidget {
  static Route route(String videoFile) => MaterialPageRoute(
        builder: (_) => RouteVideoScreen(videoFile: videoFile),
      );

  const RouteVideoScreen({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  final String videoFile;

  @override
  State<RouteVideoScreen> createState() => _RouteVideoScreenState();
}

class _RouteVideoScreenState extends State<RouteVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
      ],
    );

    _videoPlayerController = VideoPlayerController.network(widget.videoFile);
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(0.0);
    _videoPlayerController.addListener(_togglePlaying);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  void _togglePlaying() {
    setState(() {
      _isPlaying = _videoPlayerController.value.isPlaying;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_togglePlaying);
    _videoPlayerController.dispose();

    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('route-video'),
      appBar: AppBar(
        title: Text('Beta Video'),
        leading: FreeBetaBackButton(),
      ),
      backgroundColor: FreeBetaColors.black,
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator(
                color: FreeBetaColors.white,
              );
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: FreeBetaSizes.m),
                    child: ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: _videoPlayerController,
                      builder: (context, value, _) => _VideoProgressBar(
                        position: value.position,
                        duration: value.duration,
                        videoPlayerController: _videoPlayerController,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: FreeBetaSizes.xxxl),
                    child: ElevatedButton(
                      child: SizedBox(
                        width: FreeBetaSizes.xxxl,
                        child: Text(
                          _isPlaying ? 'Pause' : 'Play',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _VideoProgressBar extends StatelessWidget {
  const _VideoProgressBar({
    Key? key,
    required this.position,
    required this.duration,
    required this.videoPlayerController,
  }) : super(key: key);

  final Duration position;
  final Duration duration;
  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: videoPlayerController,
      builder: (context, value, _) {
        return SizedBox(
          height: FreeBetaSizes.xxxl,
          child: SliderTheme(
            data: SliderThemeData(
              trackShape: _GradientSliderTrackShape(
                gradient: FreeBetaGradients.filterBar,
                darkenInactive: true,
              ),
            ),
            child: Slider(
              value: position.inMilliseconds.toDouble(),
              onChangeStart: (_) => videoPlayerController.pause(),
              onChangeEnd: (_) => videoPlayerController.play(),
              onChanged: (value) {
                videoPlayerController
                    .seekTo(Duration(milliseconds: value.toInt()));
              },
              min: 0,
              max: duration.inMilliseconds.toDouble(),
            ),
          ),
        );
      },
    );
  }
}

class _GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const _GradientSliderTrackShape({
    required this.gradient,
    required this.darkenInactive,
  });

  final LinearGradient gradient;
  final bool darkenInactive;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top - (additionalActiveTrackHeight / 2),
      thumbCenter.dx,
      trackRect.bottom + (additionalActiveTrackHeight / 2),
    );

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor)
        : activeTrackColorTween;

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

    final leftTrackPaint = activePaint;
    final rightTrackPaint = inactivePaint;

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top - (additionalActiveTrackHeight / 2),
        thumbCenter.dx,
        trackRect.bottom + (additionalActiveTrackHeight / 2),
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        topRight: trackRadius,
        bottomRight: trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
