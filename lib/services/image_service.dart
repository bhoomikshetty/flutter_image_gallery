import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'package:flutter_image_gallery/models/image_data.dart';

var uuid = const Uuid();

class ImageService {
  static String url = 'https://pixabay.com/api';
  static String apiKey = '33676120-c64db63200eef52446358cb33';

  Future<List<ImageData>> getImages({int perPage = 5, int page = 1}) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('$url?key=$apiKey&page=$page&perPage=$perPage&type=photo&safesearch=true'),
      );

      if (res.statusCode == 200) {
        final Map response = json.decode(res.body);
        final List images = response['hits'];
        return images.map((image) => ImageData.fromMap(image)).toList();
      } else {
        if (kDebugMode) {
          print('Error : ${res.statusCode}');
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return [];
  }
}
