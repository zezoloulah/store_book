class CartUser {
  final int? userId;
  final String? userName;

  CartUser({this.userId, this.userName});

  factory CartUser.fromJson(Map<String, dynamic> json) {
    return CartUser(userId: json['user_id'], userName: json['user_name']);
  }
}
