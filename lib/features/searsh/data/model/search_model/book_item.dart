import 'package:store_book/features/searsh/data/model/search_model/volum_enfo.dart';

class BookItem {
  final String id;
  final VolumeInfo volumeInfo;

  BookItem({required this.id, required this.volumeInfo});

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json['id'] ?? '',
      volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] ?? {}),
    );
  }
}
