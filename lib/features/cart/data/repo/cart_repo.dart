import 'package:dartz/dartz.dart';
import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/features/cart/data/model/get_cart_model.dart';
import 'package:store_book/features/cart/data/model/place_order/place_order_model.dart';
import 'package:store_book/features/cart/data/model/remove_from_cart/cart_response.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getCart();
  Future<Either<Failure, CartModel>> updateCart(int? cartId, int? quantity);
  Future<Either<Failure, OrderPlacedModel>> placeOrder(
    int id,
    String name,
    String phone,
    String email,
    String address,
  );
  Future<Either<Failure, CartRemoveResponseModel>> removeFromCart(
    int id,
  );
}
