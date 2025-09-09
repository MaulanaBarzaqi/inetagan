import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/domain/usecases/get_banner_list_usecase.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerListUsecase _usecase;

  BannerBloc(this._usecase) : super(BannerInitial()) {
    on<OnBannerEvent>((event, emit) async {
      emit(BannerLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) {
          print('BannerBloc Error: ${failure.message}');
          emit(BannerFailed(failure.message));
        },

        (data) {
          print('BannerBloc Success: ${data.length} banners');
          emit(BannerSuccess(data));
        },
      );
    });
  }
}
