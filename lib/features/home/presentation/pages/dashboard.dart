import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/home/presentation/cubit/dashboard_cubit.dart';

class Dashboard extends StatelessWidget {
  // final Widget child;
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouter.of(
      context,
    ).routeInformationProvider.value.uri.toString();

    final cubit = context.read<DashboardCubit>();
    final currenIndex = cubit.getTabIndexFromPath(location);

    return PopScope(
      canPop: false,
      child: Scaffold(
        // body: child,
        bottomNavigationBar: Material(
          elevation: 10,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: NavigationBar(
              indicatorColor: AppColors.primary.withValues(alpha: 0.3),
              selectedIndex: currenIndex,
              onDestinationSelected: (index) {
                _navigateToTab(context, index);
              },
              destinations: _destinations,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final cubit = context.read<DashboardCubit>();
    final path = '/dashboard${cubit.getCurrentTabPath(index)}';
    context.go(path);
  }

  final List<NavigationDestination> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.home, color: AppColors.secondary),
      label: 'Home',
      selectedIcon: Icon(Icons.home, color: AppColors.primary),
    ),
    const NavigationDestination(
      icon: Icon(Icons.history, color: AppColors.secondary),
      label: 'History',
      selectedIcon: Icon(Icons.history, color: AppColors.primary),
    ),
    const NavigationDestination(
      icon: Icon(Icons.wifi, color: AppColors.secondary),
      label: 'Internet',
      selectedIcon: Icon(Icons.wifi, color: AppColors.primary),
    ),
    const NavigationDestination(
      icon: Icon(Icons.account_box_rounded, color: AppColors.secondary),
      label: 'Profile',
      selectedIcon: Icon(Icons.account_box_rounded, color: AppColors.primary),
    ),
  ];
}
