import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/usecases/get_all_internetplan_usecase.dart';

part 'all_internetplan_event.dart';
part 'all_internetplan_state.dart';

class AllInternetplanBloc
    extends Bloc<AllInternetplanEvent, AllInternetplanState> {
  final GetAllInternetplanUsecase _usecase;

  AllInternetplanBloc(this._usecase) : super(AllInternetplanInitial()) {
    on<OnAllInternetplanEvent>((event, emit) async {
      emit(AllInternetplanLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(AllInternetplanFailed(failure.message)),
        (data) => emit(AllInternetplanSuccess(data)),
      );
    });
  }
}
