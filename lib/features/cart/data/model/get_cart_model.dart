import '../../../../core/const/model/cart_item.dart';

class CartModel {
  final CartData data;
  final String message;
  final List<dynamic> error;
  final int status;

  CartModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      data: CartData.fromJson(json['data']),
      message: json['message'],
      error: json['error'],
      status: json['status'],
    );
  }
}
class CartData {
  final int id;
  final CartUser user;
  final String total;
  final List<CartItem> cartItems;

  CartData({
    required this.id,
    required this.user,
    required this.total,
    required this.cartItems,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      user: CartUser.fromJson(json['user']),
      total: json['total'],
      cartItems: List<CartItem>.from(
        json['cart_items'].map((e) => CartItem.fromJson(e)),
      ),
    );
  }
}
class CartUser {
  final int userId;
  final String userName;

  CartUser({required this.userId, required this.userName});

  factory CartUser.fromJson(Map<String, dynamic> json) {
    return CartUser(userId: json['user_id'], userName: json['user_name']);
  }
}
