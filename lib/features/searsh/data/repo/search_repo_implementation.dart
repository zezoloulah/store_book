import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/core/service/api_service.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/categorie_response_model.dart';
import 'package:store_book/features/searsh/data/model/search_model/book_response.dart';
import 'package:store_book/features/searsh/data/repo/search_repo.dart';

class SearchRepoImplementation extends SearchRepo {
  final ApiService apiService;

  SearchRepoImplementation({required this.apiService});
  @override
  Future<Either<Failure, CategoriesResponseModel>> getCategory() async {
    try {
      var res = await apiService.getData(endpoint: "/categories");
      var data = CategoriesResponseModel.fromJson(res);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BooksResponse>> search({required String search}) async {
    try {
      var res = await apiService.getSearchData(search: search);
      var data = BooksResponse.fromJson(res);
      
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
