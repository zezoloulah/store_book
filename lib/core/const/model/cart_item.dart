class CartItem {
  final int itemId;
  final int productId;
  final String productName;
  final String productImage;
  final String productPrice;
  final int productDiscount;
  final double priceAfterDiscount;
  final int stock;
  final int quantity;
  final double total;

  CartItem({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDiscount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.quantity,
    required this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'],
      productId: json['item_product_id'],
      productName: json['item_product_name'],
      productImage: json['item_product_image'],
      productPrice: json['item_product_price'],
      productDiscount: json['item_product_discount'],
      priceAfterDiscount: (json['item_product_price_after_discount'] as num)
          .toDouble(),
      stock: json['item_product_stock'],
      quantity: json['item_quantity'],
      total: (json['item_total'] as num).toDouble(),
    );
  }
}
