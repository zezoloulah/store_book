import 'package:store_book/features/searsh/data/model/search_model/image_links.dart';

class VolumeInfo {
  final String title;
  final String subtitle;
  final List<String> authors;
  final String publishedDate;
  final int pageCount;
  final String language;
  final ImageLinks imageLinks;

  VolumeInfo({
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publishedDate,
    required this.pageCount,
    required this.language,
    required this.imageLinks,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      publishedDate: json['publishedDate'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      language: json['language'] ?? '',
      imageLinks: ImageLinks.fromJson(json['imageLinks'] ?? {}),
    );
  }
}
