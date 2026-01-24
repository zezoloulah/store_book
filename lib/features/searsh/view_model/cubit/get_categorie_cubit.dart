import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/categorie_model.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/categorie_response_model.dart';
import 'package:store_book/features/searsh/data/repo/search_repo.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit(this.searchRepo) : super(GetCategoryInitial());
  final SearchRepo searchRepo;
  Future getCategory() async {
    emit(GetCategoryLoading());
    var res = await searchRepo.getCategory();
    res.fold(
      (failure) {
        emit(GetCategoryFailure(errMassage: failure.errMassage));
      },
      (data) {
        emit(GetCategorySuccess(data: data));
      },
    );
  }
}
