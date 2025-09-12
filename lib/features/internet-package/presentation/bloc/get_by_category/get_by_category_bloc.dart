import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_by_category_usecase.dart';

part 'get_by_category_event.dart';
part 'get_by_category_state.dart';

class GetByCategoryBloc extends Bloc<GetByCategoryEvent, GetByCategoryState> {
  final GetByCategoryUsecase _usecase;

  GetByCategoryBloc(this._usecase) : super(GetByCategoryInitial()) {
    on<OnGetByCategoryEvent>((event, emit) async {
      emit(GetByCategoryLoading());
      final result = await _usecase.call(event.categorySlug);
      result.fold(
        (failure) => emit(GetByCategoryFailed(failure.message)),
        (data) => emit(GetByCategorySuccess(data)),
      );
    });

    on<OnResetGetByCategoryEvent>((event, emit) {
      emit(GetByCategoryInitial());
    });
  }
}
