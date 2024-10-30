import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core_export.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String sourceUrl;

  const VideoPlayerWidget({super.key, required this.sourceUrl});
  @override
  Key? get key => const Key("video_show_box");

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool hasError = false;

  @override
  initState() {
    _initController();
    super.initState();
  }

  _initController() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.tryParse(widget.sourceUrl) ?? Uri(),
    );

    _videoPlayerController
        .initialize()
        .catchError((_) => setState(() => hasError = true))
        .then((_) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return hasError
        ? _showError()
        : Directionality(
            textDirection: TextDirection.ltr,
            child: CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
          );
  }

  Widget _showError() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 50,
            spreadRadius: -30,
          ),
        ],
      ),
      child: Icon(
        size: 80,
        FontAwesomeIcons.linkSlash,
        color: ColorPallet.text,
      ),
    );
  }
}
