import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* Models */
import 'package:smap_studio/models/post.dart';

class GalleryApiProvider {
  Future<Map> getPosts() async {
    try {
      var response = await http.get('http://116.202.241.23:3333/api/posts');

      List<Post> postsList = [];

      for (var singlePostJson in json.decode(response.body)['posts']) {
        if (singlePostJson['id'] != null) {
          postsList.add(
            Post.fromApiJson(singlePostJson)
          );
        }
      }

      return {
        'data': postsList
      };
    } on Error catch (_) {
      return {
        'errors': {
          'network': _
        }
      };
    } catch (_) {
      return {
        'errors': {
          'network': 'Something went wrong'
        }
      };
    }
  }

  Future<bool> sendMediaId({@required String mediaId}) async {
    try {
      var response = await http.post('http://116.202.241.23:3333/api/posts/$mediaId');

      if (json.decode(response.body)['id'] != null) {
        return true;
      }

      return false;
    } on Error catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}