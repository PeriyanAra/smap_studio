import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:smap_studio/blocs/gallery/bloc.dart';

/* Models */
import 'package:smap_studio/models/post.dart';

/* Wdigets */
import 'package:smap_studio/screens/homepage/photo_post.dart';
import 'package:smap_studio/screens/homepage/top_section.dart';
import 'package:smap_studio/screens/homepage/video_post.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GalleryBloc _galleryBloc;

  @override
  void initState() { 
    super.initState();
    
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);

    _galleryBloc.add(
      FetchGallery()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (BuildContext context, GalleryState galleryState) {
        List<Post> postsList = [];

        if (galleryState is GalleryLoaded) {
          postsList = galleryState.postsList;
        }

        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                transform: GradientRotation(2.91382719),
              )
            ),
            child: ListView.builder(
              itemCount: postsList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return TopSection();
                }

                if (postsList[index - 1].isVideo) {
                  return VideoPost(
                    post: postsList[index - 1],
                  );
                } else {
                  return PhotoPost(
                    post: postsList[index - 1]
                  );
                }
              },
            ),
          ),
        );
      }
    );
  }
}