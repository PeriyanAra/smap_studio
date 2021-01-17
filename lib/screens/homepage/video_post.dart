import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

/* Models */
import 'package:smap_studio/models/post.dart';

class VideoPost extends StatefulWidget {
  final Post post;

  VideoPost({
    Key key,
    @required this.post
  }) : super(key: key);

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  VlcPlayerController controller;
  bool isPlaying = false;

  @override
  void initState() { 
    super.initState();

    controller = VlcPlayerController(
      onInit: () {

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: VlcPlayer(
              aspectRatio: 16 / 9,
              url: widget.post.base + widget.post.file,
              controller: controller,
            ),
          ),
          if (!isPlaying && widget.post.poster != null) ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.post.base + widget.post.poster
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                if (!isPlaying) {
                  setState(() => isPlaying = true);
                  controller.play();
                } else {
                  setState(() => isPlaying = false);
                  controller.stop();
                }
              },
              child: Icon(
                !isPlaying ? Icons.play_circle_fill : Icons.stop_circle,
                size: 24,
                color: Colors.red,
              )
            ),
          )
        ],
      ),
    );
  }
}