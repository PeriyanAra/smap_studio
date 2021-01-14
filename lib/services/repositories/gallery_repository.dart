import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/* Api providers */
import 'package:smap_studio/services/repositories/api_providers/gallery_api_provider.dart';

class GalleryRepository {
  GalleryApiProvider _galleryApiProvider;

  GalleryRepository() {
    _galleryApiProvider = GalleryApiProvider();
  }



  Future<Map> getPosts() async {
    return _galleryApiProvider.getPosts();
  }

  Future<bool> sendMediaId({@required String mediaId}) async {
    return _galleryApiProvider.sendMediaId(mediaId: mediaId);
  }

  Stream<Map> uploadPhoto({@required File imageFile}) async* {
    final StreamController _streamController = StreamController<Map>();
    Stream<Map> progressStream = _streamController.stream;
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path, filename: "upload.jpg")
    });

    dio.post(
      'http://116.202.241.23:3333/api/media/image', 
      data: formData,
      onSendProgress: (int sent, int total) {
        double progress = (sent * 100) / total;

        _streamController.sink.add(
          {
            'status': 'uploading',
            'progress': progress
          }
        );
      }
    ).then((Response value) {
      _streamController.sink.add(
        {
          'status': 'finished',
          'mediaId': value.data['mediaId']
        }
      );
    });

    yield* progressStream;
  }
}