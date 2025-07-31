import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarCubit extends Cubit<int> {
  TabbarCubit() : super(0);

  void change(int i) => emit(i);

  final List<String> labels = [
    'semua paket',
    'paket pelajar',
    'paket keluarga',
    'paket korporat',
  ];
}
