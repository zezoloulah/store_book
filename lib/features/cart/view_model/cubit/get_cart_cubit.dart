import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_book/features/cart/data/model/get_cart_model.dart';
import 'package:store_book/features/cart/data/repo/cart_repo.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit(this.cartRepo) : super(GetCartInitial());
  final CartRepo cartRepo;
  Future getCarts() async {
    emit(GetCartLoading());

    var res = await cartRepo.getCart();
    res.fold(
      (failure) {
        emit(GetCartFailure(errMassage: failure.errMassage));
      },
      (data) {
        emit(GetCartSuccess(data: data));
      },
    );
  }
  int get cartCount {
    if (state is GetCartSuccess) {
      CartModel cart = (state as GetCartSuccess).data;
      return cart.data.cartItems.length;
    }
    return 0;
  }
}
