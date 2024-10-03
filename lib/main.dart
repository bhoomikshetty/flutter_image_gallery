import 'package:flutter/material.dart';
import 'package:flutter_image_gallery/common/constants.dart';
import 'package:get/get.dart';

import 'package:flutter_image_gallery/controller.dart';
import 'package:flutter_image_gallery/widgets/image_card_widget.dart';
import 'package:flutter_image_gallery/widgets/image_shimmer_widget.dart';

void main() {
  runApp(const ImageGalleryApp());
}

class ImageGalleryApp extends StatelessWidget {
  const ImageGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gallery',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ImageGallery(),
    );
  }
}

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final ScrollController scrollController = ScrollController();
  GalleryController controller = Get.put(GalleryController());

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - scrollOffsetForPaginationinPx) {
        await controller.fetchImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final int col = size.width ~/ 250;

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          const SliverAppBar(
            floating: true,
            title: Text('Image Gallery'),
          ),
          Obx(
            () {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: col < 1 ? 1 : col,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: controller.images.length + col,
                  itemBuilder: (context, index) {
                    if (index >= controller.images.length) {
                      return const ImageShimmerWidget();
                    }

                    return ImageCard(
                      controller: controller,
                      image: controller.images[index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
