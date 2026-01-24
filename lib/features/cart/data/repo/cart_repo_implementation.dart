// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/core/service/api_service.dart';
import 'package:store_book/features/cart/data/model/get_cart_model.dart';
import 'package:store_book/features/cart/data/model/place_order/place_order_model.dart';
import 'package:store_book/features/cart/data/model/remove_from_cart/cart_response.dart';
import 'package:store_book/features/cart/data/repo/cart_repo.dart';

class CartRepoImplementation extends CartRepo {
  ApiService apiService;
  CartRepoImplementation({required this.apiService});
  @override
  Future<Either<Failure, CartModel>> getCart() async {
    try {
      var res = await apiService.getData(endpoint: "/cart");
      var data = CartModel.fromJson(res);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateCart(
    int? cartId,
    int? quantity,
  ) async {
    try {
      var res = await apiService.upData(endpoint: "/update-cart");
      var data = CartModel.fromJson(res);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderPlacedModel>> placeOrder(
    int id,
    String name,
    String phone,
    String email,
    String address,
  ) async {
    try {
      var res = await apiService.upData(
        endpoint: "/update-cart",
        name: name,
        id: id,
        phone: phone,
        email: email,
        address: address,
      );
      var data = OrderPlacedModel.fromJson(res);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartRemoveResponseModel>> removeFromCart(int id) async {
    try {
      var res = await apiService.upData(
        endpoint: "/remove-from-cart",
        cartItemid: id,
      );
      var data = CartRemoveResponseModel.fromJson(res);
      return right(data);
    } catch (e) {
        if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
