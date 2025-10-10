import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/all_package/package_list_view.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_widget.dart';

import '../../bloc/all_internet_package/all_internet_package_bloc.dart';
import '../../bloc/search_internet_package/search_internet_package_bloc.dart';

class AllPackagesContent extends StatelessWidget {
  final TextEditingController searchController;
  const AllPackagesContent({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
      context.read<SearchInternetPackageBloc>().add(
        OnResetInternetPackageEvent(),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: BlocBuilder<SearchInternetPackageBloc, SearchInternetPackageState>(
        builder: (context, searchState) {
          // search state
          if (searchState is SearchInternetPackageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (searchState is SearchInternetPackageFailed) {
            return FailedWidget(height: 300, message: searchState.message);
          }
          if (searchState is SearchInternetPackageSuccess) {
            if (searchState.data.isEmpty) {
              return _buildSearchNotFound(context);
            }
            return PackageListView(list: searchState.data);
          }
          // default all packages state
          return BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
            builder: (context, allState) {
              if (allState is AllInternetPackageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (allState is AllInternetPackageFailed) {
                return FailedWidget(height: 300, message: allState.message);
              }
              if (allState is AllInternetPackageSuccess) {
                return PackageListView(list: allState.data);
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchNotFound(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.search_off, size: 50, color: Colors.grey),
        const Gap(16),
        Text(
          'tidak ditemukan paket dengan kata kunci "${searchController.text}"',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
        const Gap(20),
        ElevatedButton(
          onPressed: () {
            searchController.clear();
            context.read<SearchInternetPackageBloc>().add(
              OnResetInternetPackageEvent(),
            );
          },
          child: const Text('Reset Pencarian'),
        ),
      ],
    );
  }
}
