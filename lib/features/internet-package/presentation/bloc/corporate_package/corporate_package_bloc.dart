import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_corporate_package_usecase.dart';

part 'corporate_package_event.dart';
part 'corporate_package_state.dart';

class CorporatePackageBloc
    extends Bloc<CorporatePackageEvent, CorporatePackageState> {
  final GetCorporatePackageUsecase _usecase;

  CorporatePackageBloc(this._usecase) : super(CorporatePackageInitial()) {
    on<OnCorporatePackageEvent>((event, emit) async {
      emit(CorporatePackageLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(CorporatePackageFailed(failure.message)),
        (data) => emit(CorporatePackageSuccess(data)),
      );
    });
  }
}
