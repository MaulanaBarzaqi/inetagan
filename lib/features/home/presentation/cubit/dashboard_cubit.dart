import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/presentation/pages/home_page.dart';
import 'package:inetagan/features/home/presentation/pages/profile_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/all_packages_page.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  change(int i) => emit(i);

  final List menuDashboard = [
    ['Home', Icons.home, HomePage()],
    ['History', Icons.history, Center(child: Text("history"))],
    ['Internet', Icons.wifi, AllPackagesPage()],
    ['Profile', Icons.account_box_rounded, ProfilePage()],
  ];

  Widget get page => menuDashboard[state][2];
}
