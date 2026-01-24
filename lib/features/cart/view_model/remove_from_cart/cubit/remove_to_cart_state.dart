part of 'remove_to_cart_cubit.dart';

@immutable
sealed class RemoveToCartState {}

final class RemoveToCartInitial extends RemoveToCartState {}

final class RemoveToCartSuccess extends RemoveToCartState {
  final CartRemoveResponseModel data;

  RemoveToCartSuccess({required this.data});
}

final class RemoveToCartLoading extends RemoveToCartState {}

final class RemoveToCartFailure extends RemoveToCartState {
  final String errMassage;

  RemoveToCartFailure({required this.errMassage});
}
