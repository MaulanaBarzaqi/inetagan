import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/usecases/subscribe_usecase.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  final SubscribeUsecase _usecase;

  SubscribeBloc(this._usecase) : super(SubscribeInitial()) {
    on<OnSubscribeEvent>((event, emit) async {
      emit(SubscribeLoading());
      final result = await _usecase.call(
        event.name,
        event.nik,
        event.phone,
        event.address,
        event.userId,
        event.internetPackageId,
      );
      result.fold(
        (failure) => emit(SubscribeFailed(failure.message)),
        (data) => emit(SubscribeSuccess(data)),
      );
    });
  }
}
