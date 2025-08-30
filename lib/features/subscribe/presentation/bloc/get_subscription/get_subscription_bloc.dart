import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/usecases/get_subscription_usecase.dart';

part 'get_subscription_event.dart';
part 'get_subscription_state.dart';

class GetSubscriptionBloc
    extends Bloc<GetSubscriptionEvent, GetSubscriptionState> {
  final GetSubscriptionUsecase _usecase;

  GetSubscriptionBloc(this._usecase) : super(GetSubscriptionInitial()) {
    on<OnGetSubscriptionEvent>((event, emit) async {
      emit(GetSubscriptionLoading());
      final result = await _usecase.call(event.userId);

      result.fold(
        (failure) => emit(GetSubscriptionFailed(failure.message)),
        (data) => emit(GetSubscriptionSuccess(data)),
      );
    });
  }
}
