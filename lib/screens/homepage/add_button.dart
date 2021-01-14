import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:smap_studio/blocs/gallery/bloc.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  GalleryBloc _galleryBloc;

  @override
  void initState() { 
    super.initState();
    
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile.path);
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (croppedImage  != null) {
      _galleryBloc.add(
        UploadImage(
          imageFile: croppedImage
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: Material(
        color: Color(0xFF30CFD0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: _getFromGallery,
          child: Stack(
            children: [
              Center(
                child: Text(
                  'Сделать запись',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 12,
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 24.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}