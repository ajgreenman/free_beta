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
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
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
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: FreeBetaSizes.m,
                  child: _VideoControlBar(
                    isPlaying: _videoPlayerController.value.isPlaying,
                    onPlayPressed: () {
                      setState(() {
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }
                      });
                    },
                    onRestartPressed: () {
                      setState(() {
                        _videoPlayerController.seekTo(Duration.zero);
                      });
                    },
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

class _VideoControlBar extends StatelessWidget {
  const _VideoControlBar({
    Key? key,
    required this.isPlaying,
    required this.onPlayPressed,
    required this.onRestartPressed,
  }) : super(key: key);

  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onRestartPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: onPlayPressed,
          child: SizedBox(
            width: FreeBetaSizes.xxxl,
            child: Text(
              isPlaying ? 'Pause' : 'Play',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onRestartPressed,
          child: SizedBox(
            width: FreeBetaSizes.xxxl,
            child: Text(
              'Restart',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
