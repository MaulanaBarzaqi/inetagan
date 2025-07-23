import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  SubscribeBloc() : super(SubscribeInitial()) {
    on<SubscribeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
