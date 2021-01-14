import 'package:flutter_bloc/flutter_bloc.dart';

/* Services */
import 'package:smap_studio/services/repositories/gallery_repository.dart';

import 'bloc.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryRepository _galleryRepository;

  GalleryBloc(initialState) : super(initialState) {
    _galleryRepository = GalleryRepository();
  }

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is FetchGallery) {
      yield* _fetchGallery(event);
    } else if (event is UploadImage) {
      yield* _uploadImage(event);
    } else if (event is UpdateState) {
      final currentState = state as GalleryLoaded;

      yield currentState.copyWith(
        uploadProgress: event.uploadProgress,
        postsList: event.postsList
      );
    }
  }



  Stream<GalleryState> _fetchGallery(GalleryEvent event) async* {
    var galleryposts = await _galleryRepository.getPosts();

    if (galleryposts['data'] != null) {
      yield GalleryLoaded(
        postsList: galleryposts['data']
      );
    }
  }

  Stream<GalleryState> _uploadImage(UploadImage event) async* {
    _galleryRepository.uploadPhoto(imageFile: event.imageFile).listen((Map uploadStreamEvent) async {
      if (
        uploadStreamEvent['status'] == 'uploading' &&
        uploadStreamEvent['progress'] != null
      ) {
        this.add(
          UpdateState(
            uploadProgress: uploadStreamEvent['progress']
          )
        );
      } else if (
        uploadStreamEvent['status'] == 'finished' &&
        uploadStreamEvent['mediaId'] != null
      ) {
        bool mediaIdSendSuccess = await _galleryRepository.sendMediaId(mediaId: uploadStreamEvent['mediaId']);

        if (mediaIdSendSuccess) {
          this.add(
            FetchGallery()
          );
        }
      }
    });
  }
}