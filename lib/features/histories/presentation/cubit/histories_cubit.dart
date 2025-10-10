import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'histories_state.dart';

class HistoriesCubit extends Cubit<HistoriesState> {
  HistoriesCubit() : super(HistoriesInitial());
}
