import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BetterPlayer.network(
          '${widget.post.base + widget.post.file}',
          betterPlayerConfiguration: BetterPlayerConfiguration(
            placeholder: widget.post.poster != null ? Image.network(
              widget.post.base + widget.post.poster,
            ) : null
          ),
        )
      ),
    );
  }
}