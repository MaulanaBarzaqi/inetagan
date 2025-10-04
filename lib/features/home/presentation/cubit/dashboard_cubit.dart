import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  void changeTab(int index) => emit(index);

  String getCurrentTabPath(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/histories';
      case 2:
        return '/internet-packages';
      case 3:
        return '/profile';
      default:
        return '/home';
    }
  }

  int getTabIndexFromPath(String path) {
    if (path.contains('/home')) return 0;
    if (path.contains('/histories')) return 1;
    if (path.contains('/internet-packages')) return 2;
    if (path.contains('/profile')) return 3;
    return 0;
  }
}
