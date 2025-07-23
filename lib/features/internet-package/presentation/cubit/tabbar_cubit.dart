import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/pages/all_packages_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/corporate_packages_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/family_packages_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/student_packages_page.dart';

class TabbarCubit extends Cubit<int> {
  TabbarCubit() : super(0);

  void change(int i) => emit(i);

  final List<Widget> pages = [
    AllPackagesPage(),
    StudentPackagesPage(),
    FamilyPackagesPage(),
    CorporatePackagesPage(),
  ];

  final List<String> labels = [
    'semua paket',
    'paket pelajar',
    'paket keluarga',
    'paket korporat',
  ];
}
