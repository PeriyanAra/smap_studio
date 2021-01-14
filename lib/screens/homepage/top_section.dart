import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:smap_studio/blocs/gallery/bloc.dart';

/* Widgets */
import 'package:smap_studio/screens/homepage/add_button.dart';

class TopSection extends StatefulWidget {
  TopSection({Key key}) : super(key: key);

  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (BuildContext context, GalleryState galleryState) {
        double uploadProgress;
        
        if (galleryState is GalleryLoaded) {
          uploadProgress = galleryState.uploadProgress;
        }

        return Container(
          margin: EdgeInsets.only(top: 73),
          child: Column(
            children: [
              Text(
                'Это тестовое задание',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1, bottom: 32),
                child: Text(
                  'This is test task',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white
                  ),
                ),
              ),
              uploadProgress == null ? AddButton() : LinearProgressIndicator(
                value: uploadProgress,
                backgroundColor: Colors.white,
              ),
              Container(
                height: 32,
              )
            ],
          ),
        );
      }
    );
  }
}