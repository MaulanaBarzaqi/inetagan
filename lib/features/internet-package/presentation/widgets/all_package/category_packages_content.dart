import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/all_package/package_list_view.dart';

import '../../../../category/presentation/cubit/category_cubit.dart';
import '../../bloc/get_by_category/get_by_category_bloc.dart';
import '../common/failed_widget.dart';

class CategoryPackagesContent extends StatelessWidget {
  final int selectedTabIndex;
  const CategoryPackagesContent({super.key, required this.selectedTabIndex});

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      final categories = context.read<CategoryCubit>().getCategoriesWithAll();
      final selectedCategory = categories[selectedTabIndex];
      context.read<GetByCategoryBloc>().add(
        OnGetByCategoryEvent(selectedCategory.slug),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: BlocBuilder<GetByCategoryBloc, GetByCategoryState>(
        builder: (context, state) {
          if (state is GetByCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetByCategoryFailed) {
            return FailedWidget(height: 300, message: state.message);
          }
          if (state is GetByCategorySuccess) {
            return PackageListView(list: state.data);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
