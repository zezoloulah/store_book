

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/core/service/api_service.dart';
import 'package:store_book/core/service/local_data/local_service_sheard.dart';
import 'package:store_book/features/auth/login_screen%20copy/data/model/log_in_model.dart';
import 'package:store_book/features/auth/login_screen%20copy/data/repo/login_repo.dart';

class LoginRepoImplementation extends LoginRepo {
  final ApiService apiService;

  LoginRepoImplementation({required this.apiService});

  @override
  Future<Either<Failure, LoginModel>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      var logIn = await apiService.auth(
        endpoint: "/login",
        email: email,
        password: password,
      );
      var data = LoginModel.fromJson(logIn);
      await LocalService.saveToken(data.data!.token!,email);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
