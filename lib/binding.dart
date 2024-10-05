import 'package:flutter_image_gallery/controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => GalleryController());
  }
}
