import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  final String videoUrl;

  @override
  State<StatefulWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayerController.convertUrlToId(widget.videoUrl);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        params: YoutubePlayerParams(
            autoPlay: false,
            enableCaption: false,
            showFullscreenButton: true,
            interfaceLanguage: 'sk',
            color: secondaryColor.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _controller,
    );
  }
}
