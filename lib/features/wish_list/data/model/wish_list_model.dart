

class WishListModel {
  final WishlistPagination data;
  final String message;
  final List<dynamic> error;
  final int status;

  WishListModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      data: WishlistPagination.fromJson(json['data']),
      message: json['message'] ?? '',
      error: json['error'] ?? [],
      status: json['status'],
    );
  }
}
class WishlistPagination {
  final int currentPage;
  final List<WishlistItem> items;
  final int total;
  final int perPage;
  final int lastPage;

  WishlistPagination({
    required this.currentPage,
    required this.items,
    required this.total,
    required this.perPage,
    required this.lastPage,
  });

  factory WishlistPagination.fromJson(Map<String, dynamic> json) {
    return WishlistPagination(
      currentPage: json['current_page'],
      items: (json['data'] as List)
          .map((e) => WishlistItem.fromJson(e))
          .toList(),
      total: json['total'],
      perPage: json['per_page'],
      lastPage: json['last_page'],
    );
  }
}

class WishlistItem {
  final int id;
  final String name;
  final String price;
  final String category;
  final String image;
  final int discount;
  final int stock;
  final String description;
  final int bestSeller;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.discount,
    required this.stock,
    required this.description,
    required this.bestSeller,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      discount: json['discount'],
      stock: json['stock'],
      description: json['description'],
      bestSeller: json['best_seller'],
    );
  }
}
