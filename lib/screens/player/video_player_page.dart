import 'package:courses/constants/colors.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final YoutubePlayerController _playerController = YoutubePlayerController(
    initialVideoId: "cQr9EBFBJxQ",
    flags: const YoutubePlayerFlags(
      loop: false,
      autoPlay: true,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ConstColors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: _buildBody(),
    );

  }

  SafeArea _buildBody() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _showPlayer(),
              SetTextWidget(
                _playerController.metadata.title,
                weight: FontWeight.w700,
              ),
              SetTextWidget(_playerController.metadata.author),
            ],
          ),
        ),
      );

  _showPlayer() => YoutubePlayer(
        controller: _playerController,
        width: MediaQuery.of(context).size.width,
      );
}