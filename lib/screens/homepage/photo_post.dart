import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

/* Models */
import 'package:smap_studio/models/post.dart';

class PhotoPost extends StatelessWidget {
  final Post post;

  const PhotoPost({
    Key key,
    @required this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 28),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            post.base + post.preview,
          )
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailScreen(
            post: post
          );
        }));
      }
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Post post;

  const DetailScreen({
    Key key,
    @required this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Center(
              child: Hero(
                tag: 'imageHero',
                child: PinchZoom(
                  image: Image.network(
                    post.base + post.file,
                  ),
                  zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                  resetDuration: const Duration(milliseconds: 100),
                  maxScale: 50,
                )
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            child: GestureDetector(
              child: Icon(
                Icons.close
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}