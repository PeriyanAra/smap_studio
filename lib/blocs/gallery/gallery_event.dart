import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

/* Models */
import 'package:smap_studio/models/post.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}



class FetchGallery extends GalleryEvent {
  @override
  List<Object> get props => [
    
  ];
}

class UploadImage extends GalleryEvent {
  final File imageFile;

  UploadImage({
    @required this.imageFile
  });

  @override
  List<Object> get props => [
    
  ];
}

class UpdateState extends GalleryEvent {
  final double uploadProgress;
  final List<Post> postsList;

  UpdateState({
    this.uploadProgress,
    this.postsList
  });

  @override
  List<Object> get props => [
    uploadProgress, postsList
  ];
}