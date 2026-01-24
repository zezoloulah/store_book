import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_book/features/searsh/data/model/search_model/book_response.dart';
import 'package:store_book/features/searsh/data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  Future search(String search) async {
    emit(SearchLoading());
    var res = await searchRepo.search(search:search);
    res.fold(
      (failure) {
        emit(SearchFailure(errMassage: failure.errMassage));
      },
      (data) {
        emit(SearchSuccess(data: data));
      },
    );
  }
}
