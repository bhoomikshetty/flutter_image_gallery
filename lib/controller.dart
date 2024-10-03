import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:flutter_image_gallery/models/image_data.dart';
import 'package:flutter_image_gallery/services/image_service.dart';

class GalleryController extends GetxController {
  final ImageService _imageService = ImageService();

  List<ImageData> images = <ImageData>[].obs;
  RxBool isFetchingImages = false.obs;
  int page = 1;
  int perPage = 20;

  @override
  void onInit() async {
    super.onInit();
    await fetchImage();
  }

  Future<void> fetchImage() async {
    if (isFetchingImages.value) {
      return;
    }
    isFetchingImages.value = true;
    try {
      final List<ImageData> fetchedImages = await _imageService.getImages(page: page, perPage: perPage);
      images.addAll(fetchedImages);
      page++;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isFetchingImages.value = false;
  }

  void updateImageLoaded(String id) {
    images = images.map((image) => image.id == id ? image.copyWith(isLoaded: true) : image).toList();
  }
}
