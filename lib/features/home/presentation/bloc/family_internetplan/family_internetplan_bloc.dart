import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/usecases/get_family_internetplan_usecase.dart';

part 'family_internetplan_event.dart';
part 'family_internetplan_state.dart';

class FamilyInternetplanBloc
    extends Bloc<FamilyInternetplanEvent, FamilyInternetplanState> {
  final GetFamilyInternetplanUsecase _usecase;

  FamilyInternetplanBloc(this._usecase) : super(FamilyInternetplanInitial()) {
    on<OnFamilyInternetplanEvent>((event, emit) async {
      emit(FamilyInternetplanLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(FamilyInternetplanFailed(failure.message)),
        (data) => emit(FamilyInternetplanSuccess(data)),
      );
    });
  }
}
