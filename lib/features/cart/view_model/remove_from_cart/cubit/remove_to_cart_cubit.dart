import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_book/features/cart/data/model/remove_from_cart/cart_response.dart';
import 'package:store_book/features/cart/data/repo/cart_repo.dart';

part 'remove_to_cart_state.dart';

class RemoveToCartCubit extends Cubit<RemoveToCartState> {
  RemoveToCartCubit(this.cartRepo) : super(RemoveToCartInitial());
  final CartRepo cartRepo;
  Future removeFromCart(int id) async {
    emit(RemoveToCartLoading());
    var res = await cartRepo.removeFromCart(id);
    res.fold(
      (failure) {
        emit(RemoveToCartFailure(errMassage: failure.errMassage));
      },
      (data) {
        emit(RemoveToCartSuccess(data: data));
      },
    );
  }
}
