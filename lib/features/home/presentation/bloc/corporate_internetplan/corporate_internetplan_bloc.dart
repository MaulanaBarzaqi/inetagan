import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/usecases/get_corporate_internetplan_usecase.dart';

part 'corporate_internetplan_event.dart';
part 'corporate_internetplan_state.dart';

class CorporateInternetplanBloc
    extends Bloc<CorporateInternetplanEvent, CorporateInternetplanState> {
  final GetCorporateInternetplanUsecase _usecase;

  CorporateInternetplanBloc(this._usecase)
    : super(CorporateInternetplanInitial()) {
    on<OnCorporateInternetplanEvent>((event, emit) async {
      emit(CorporateInternetplanLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(CorporateInternetplanFailed(failure.message)),
        (data) => emit(CorporateInternetplanSuccess(data)),
      );
    });
  }
}
