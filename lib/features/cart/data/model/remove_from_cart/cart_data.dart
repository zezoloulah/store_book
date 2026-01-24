import 'package:store_book/features/cart/data/model/get_cart_model.dart';
import 'package:store_book/features/check_out/data/model/check_out/check_out_model.dart' hide CartUser;

class CartData {
  final int? id;
  final CartUser? user;
  final int? total;
  final List<CartItem>? cartItems;

  CartData({this.id, this.user, this.total, this.cartItems});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      user: json['user'] != null ? CartUser.fromJson(json['user']) : null,
      total: json['total'],
      cartItems: json['cart_items'] != null
          ? List<CartItem>.from(
              json['cart_items'].map((x) => CartItem.fromJson(x)),
            )
          : [],
    );
  }
}
