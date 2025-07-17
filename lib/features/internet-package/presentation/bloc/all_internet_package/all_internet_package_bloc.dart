import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_all_internet_package_usecase.dart';

part 'all_internet_package_event.dart';
part 'all_internet_package_state.dart';

class AllInternetPackageBloc
    extends Bloc<AllInternetPackageEvent, AllInternetPackageState> {
  final GetAllInternetPackageUsecase _usecase;

  AllInternetPackageBloc(this._usecase) : super(AllInternetPackageInitial()) {
    on<OnAllInternetPackageEvent>((event, emit) async {
      emit(AllInternetPackageLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(AllInternetPackageFailed(failure.message)),
        (data) => emit(AllInternetPackageSuccess(data)),
      );
    });
  }
}
