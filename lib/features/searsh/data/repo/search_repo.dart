import 'package:dartz/dartz.dart';
import 'package:store_book/core/errors/failure.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/categorie_response_model.dart';
import 'package:store_book/features/searsh/data/model/search_model/book_response.dart';

abstract class SearchRepo {
  Future<Either<Failure, CategoriesResponseModel>> getCategory();
  Future<Either<Failure, BooksResponse>> search({required String search});
}
