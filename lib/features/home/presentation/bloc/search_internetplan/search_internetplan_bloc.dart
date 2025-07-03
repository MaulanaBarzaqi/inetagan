import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/usecases/search_internetplan_usecase.dart';

part 'search_internetplan_event.dart';
part 'search_internetplan_state.dart';

class SearchInternetplanBloc
    extends Bloc<SearchInternetplanEvent, SearchInternetplanState> {
  final SearchInternetplanUsecase _usecase;

  SearchInternetplanBloc(this._usecase) : super(SearchInternetplanInitial()) {
    on<OnSearchInternetplanEvent>((event, emit) async {
      emit(SearchInternetplanLoading());
      final result = await _usecase.call(event.query);
      result.fold(
        (failure) => emit(SearchInternetplanFailed(failure.message)),
        (data) => emit(SearchInternetplanSuccess(data)),
      );
    });
  }
}
