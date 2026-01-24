class ImageLinks {
  final String thumbnail;
  final String smallThumbnail;

  ImageLinks({required this.thumbnail, required this.smallThumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      thumbnail: json['thumbnail'] ?? '',
      smallThumbnail: json['smallThumbnail'] ?? '',
    );
  }
}
