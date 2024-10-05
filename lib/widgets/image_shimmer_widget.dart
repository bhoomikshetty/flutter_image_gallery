
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerWidget extends StatelessWidget {
  const ImageShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        height: 250,
        width: 250,
      ),
    );
  }
}

