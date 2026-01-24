import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_book/core/service/local_data/local_service_sheard.dart';

class ApiService {
  final String _paseUrl = "https://codingarabic.online/api";
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;
  Future<Map<String, dynamic>> auth({
    required String endpoint,
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
  }) async {
    var res = await _dio.post(
      "$_paseUrl$endpoint",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
      data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );
    return res.data;
  }

  Future<Map<String, dynamic>> getData({required String endpoint}) async {
    var res = await _dio.get(
      "$_paseUrl$endpoint",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${LocalService.token.toString()}',
        },
      ),
    );
    return res.data;
  }

  Future<Map<String, dynamic>> upData({
    required String endpoint,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? currentPassword,
    String? newPassword,
    String? newPasswordConfirmation,
    int? id,
    int? cartItemid,
    int? quantity,
  }) async {
    var res = await _dio.post(
      "$_paseUrl$endpoint",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${LocalService.token.toString()}',
        },
      ),
      data: {
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
        "product_id": id,
        "cart_item_id": cartItemid,
        "quantity": quantity,
      },
    );
    return res.data;
  }

  Future<Map<String, dynamic>> getSearchData({required String search}) async {
    var res = await _dio.get(
      "https://www.googleapis.com/books/v1/volumes?q=$search",
    );
    
    return res.data;
  }
}
