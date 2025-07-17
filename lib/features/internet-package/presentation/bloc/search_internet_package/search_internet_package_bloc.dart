import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/search_internet_package_usecase.dart';

part 'search_internet_package_event.dart';
part 'search_internet_package_state.dart';

class SearchInternetPackageBloc
    extends Bloc<SearchInternetPackageEvent, SearchInternetPackageState> {
  final SearchInternetPackageUsecase _usecase;

  SearchInternetPackageBloc(this._usecase)
    : super(SearchInternetPackageInitial()) {
    on<OnSearchInternetPackageEvent>((event, emit) async {
      emit(SearchInternetPackageLoading());
      final result = await _usecase.call(event.query);
      result.fold(
        (failure) => emit(SearchInternetPackageFailed(failure.message)),
        (data) => emit(SearchInternetPackageSuccess(data)),
      );
    });

    on<OnResetInternetPackageEvent>((event, emit) {
      emit(SearchInternetPackageInitial());
    });
  }
}
