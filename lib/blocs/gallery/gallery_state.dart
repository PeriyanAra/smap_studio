import 'package:equatable/equatable.dart';

/* Models */
import 'package:smap_studio/models/post.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}



class GalleryLoading extends GalleryState {
  @override
  List<Object> get props => [];
}

class GalleryLoaded extends GalleryState {
  final double uploadProgress;
  final List<Post> postsList;

  GalleryLoaded({
    this.uploadProgress,
    this.postsList
  });

  GalleryLoaded copyWith({
    double uploadProgress,
    List<Post> postsList
  }) {
    return GalleryLoaded(
      uploadProgress: uploadProgress ?? this.uploadProgress,
      postsList: postsList ?? this.postsList,
    );
  }

  @override
  List<Object> get props => [uploadProgress, postsList];
}