// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/core/service/api_service.dart';

import 'package:store_book/features/check_out/data/model/check_out/check_out_model.dart';
import 'package:store_book/features/check_out/data/model/governorate/governorate_response_model.dart';
import 'package:store_book/features/check_out/data/repo/check_out_repo.dart';

class CheckOutRepoImplementation extends CheckOutRepo {
  ApiService apiService;
  CheckOutRepoImplementation({required this.apiService});
  @override
  Future<Either<Failure, GovernoratesResponse>> getGovernorate() async {
    try {
      var res = await apiService.getData(endpoint: "/governorates");
      var data = GovernoratesResponse.fromJson(res);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, CartResponseModel>> checkOut() async{
      try {
        var res = await apiService.getData(endpoint: "/checkout");
        var data = CartResponseModel.fromJson(res);
        return right(data);
      } catch (e) {
        if (e is DioException) {
          return left(ServerFailure.fromDioException(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
  }

