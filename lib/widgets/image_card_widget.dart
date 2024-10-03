import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_gallery/common/functions.dart';
import 'package:flutter_image_gallery/controller.dart';
import 'package:flutter_image_gallery/models/image_data.dart';
import 'package:flutter_image_gallery/widgets/image_shimmer_widget.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({
    super.key,
    required this.controller,
    required this.image,
    this.height = 250,
    this.width = 250,
  });

  final GalleryController controller;
  final ImageData image;
  final double height;
  final double width;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with SingleTickerProviderStateMixin {

  late Tween<double> scaleTween;
  late AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleTween = Tween<double>(
      begin: widget.image.isLoaded ? 1 : 1.05,
      end: 1.0,
    );
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    scaleAnimation = scaleTween.animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.image.imageUrl,
                placeholder: (context, url) {
                  return const ImageShimmerWidget();
                },
                imageBuilder: (context, imageProvider) {
                  return ScaleTransition(
                    scale: scaleAnimation,
                    child: Image(
                      image: imageProvider,
                      height: widget.height,
                      width: widget.width,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeInCurve: Curves.easeIn,
                fadeInDuration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          Container(
            height: 0.15 * widget.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            constraints: const BoxConstraints(minHeight: 32),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0))),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  metricsConverter(widget.image.viewCount),
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Icon(
                  Icons.visibility_rounded,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  metricsConverter(widget.image.downloadCount),
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Icon(Icons.download_rounded, color: Colors.white70),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  metricsConverter(widget.image.likeCount),
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Icon(Icons.thumb_up_alt, color: Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

