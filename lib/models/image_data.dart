import 'package:flutter_image_gallery/services/image_service.dart';

class ImageData {
  ImageData({
    required this.id,
    required this.imageUrl,
    required this.likeCount,
    required this.viewCount,
    required this.downloadCount,
    this.isLoaded = false,
  });
  
  String id;
  String imageUrl;
  int likeCount;
  int viewCount;
  int downloadCount;

  bool isLoaded = false;


  ImageData copyWith({
    String? id,
    String? imageUrl,
    int? likeCount,
    int? viewCount,
    int? downloadCount,
    bool? isLoaded,
  }) {
    return ImageData(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      viewCount: viewCount ?? this.viewCount,
      downloadCount: downloadCount ?? this.downloadCount,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'webformatURL': imageUrl,
      'likes': likeCount,
      'views': viewCount,
      'downloads': downloadCount,
    };
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      id: uuid.v4(),
      imageUrl: map['webformatURL'] as String,
      likeCount: map['likes'] as int,
      viewCount: map['views'] as int,
      downloadCount: map['downloads'] as int,
    );
  }
}
