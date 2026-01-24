import 'package:store_book/features/searsh/data/model/search_model/book_item.dart';

class BooksResponse {
  final String kind;
  final int totalItems;
  final List<BookItem> items;

  BooksResponse({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    return BooksResponse(
      kind: json['kind'] ?? '',
      totalItems: json['totalItems'] ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => BookItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}
