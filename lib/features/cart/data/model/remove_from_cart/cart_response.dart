import 'package:store_book/features/cart/data/model/get_cart_model.dart';

class CartRemoveResponseModel {
  final CartData? data;
  final String? message;
  final List<dynamic>? error;
  final int? status;

  CartRemoveResponseModel({this.data, this.message, this.error, this.status});

  factory CartRemoveResponseModel.fromJson(Map<String, dynamic> json) {
    return CartRemoveResponseModel(
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
      message: json['message'],
      error: json['error'],
      status: json['status'],
    );
  }
}
