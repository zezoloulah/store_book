part of 'get_categorie_cubit.dart';

@immutable
sealed class GetCategoryState {}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategorySuccess extends GetCategoryState {
  final CategoriesResponseModel data;

  GetCategorySuccess({required this.data});
}

final class GetCategoryLoading extends GetCategoryState {}

final class GetCategoryFailure extends GetCategoryState {
  final String errMassage;

  GetCategoryFailure({required this.errMassage});
}
