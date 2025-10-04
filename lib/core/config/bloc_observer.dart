import 'package:d_method/d_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    DMethod.logTitle('Bloc created:', '${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    DMethod.logTitle('Event:', '${event.runtimeType} in ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    DMethod.logTitle(
      'state changed:',
      '${bloc.runtimeType}\nFrom: ${change.currentState.runtimeType}\nTo: ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    DMethod.logTitle(
      'bloc error:',
      '${bloc.runtimeType}\nError: $error\nStackTrace: $stackTrace',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    DMethod.logTitle('bloc closed:', '${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
