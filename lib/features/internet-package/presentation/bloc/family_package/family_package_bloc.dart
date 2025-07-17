import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_family_package_usecase.dart';

part 'family_package_event.dart';
part 'family_package_state.dart';

class FamilyPackageBloc extends Bloc<FamilyPackageEvent, FamilyPackageState> {
  final GetFamilyPackageUsecase _usecase;

  FamilyPackageBloc(this._usecase) : super(FamilyPackageInitial()) {
    on<OnFamilyPackageEvent>((event, emit) async {
      emit(FamilyPackageLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(FamilyPackageFailed(failure.message)),
        (data) => emit(FamilyPackageSuccess(data)),
      );
    });
  }
}
