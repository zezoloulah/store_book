class CartItem {
  final int? itemId;
  final int? productId;
  final String? name;
  final String? image;
  final String? price;
  final int? discount;
  final double? priceAfterDiscount;
  final int? stock;
  final int? quantity;
  final double? total;

  CartItem({
    this.itemId,
    this.productId,
    this.name,
    this.image,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.stock,
    this.quantity,
    this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'],
      productId: json['item_product_id'],
      name: json['item_product_name'],
      image: json['item_product_image'],
      price: json['item_product_price'],
      discount: json['item_product_discount'],
      priceAfterDiscount: (json['item_product_price_after_discount'] as num?)
          ?.toDouble(),
      stock: json['item_product_stock'],
      quantity: json['item_quantity'],
      total: (json['item_total'] as num?)?.toDouble(),
    );
  }
}
