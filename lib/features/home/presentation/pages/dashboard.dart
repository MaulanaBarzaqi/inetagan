import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/home/presentation/cubit/dashboard_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<DashboardCubit>().page,
      bottomNavigationBar: Material(
        elevation: 10,
        child: BlocBuilder<DashboardCubit, int>(
          builder: (context, state) {
            return Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: NavigationBar(
                selectedIndex: state,
                onDestinationSelected: (value) {
                  context.read<DashboardCubit>().change(value);
                },
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: context.read<DashboardCubit>().menuDashboard.map((
                  e,
                ) {
                  return NavigationDestination(
                    icon: Icon(e[1], color: AppColors.secondary),
                    label: e[0],
                    tooltip: e[0],
                    selectedIcon: Icon(e[1], color: AppColors.primary),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
