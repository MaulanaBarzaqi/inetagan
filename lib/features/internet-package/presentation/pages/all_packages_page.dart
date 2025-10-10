import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/pages/categories_tab_bar.dart';
import '../bloc/all_internet_package/all_internet_package_bloc.dart';
import '../bloc/get_by_category/get_by_category_bloc.dart';
import '../bloc/search_internet_package/search_internet_package_bloc.dart';
import '../widgets/package_widget.dart';

class AllPackagesPage extends StatefulWidget {
  const AllPackagesPage({super.key});

  @override
  State<AllPackagesPage> createState() => _AllPackagesPageState();
}

class _AllPackagesPageState extends State<AllPackagesPage> {
  final edtSearch = TextEditingController();
  int _selectedTabIndex = 0;

  void _search() {
    final query = edtSearch.text.trim();
    if (query.isEmpty) return;
    if (_selectedTabIndex != 0) {
      setState(() => _selectedTabIndex = 0);
    }
    context.read<SearchInternetPackageBloc>().add(
      OnSearchInternetPackageEvent(query: query),
    );
  }

  void _onTabChanged(int index, List<CategoryEntity> categories) {
    setState(() => _selectedTabIndex = index);
    final selectedCategory = categories[index];

    context.read<SearchInternetPackageBloc>().add(
      OnResetInternetPackageEvent(),
    );
    edtSearch.clear();
    // event data
    if (selectedCategory.slug == 'all') {
      context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    } else {
      context.read<GetByCategoryBloc>().add(
        OnGetByCategoryEvent(selectedCategory.slug),
      );
    }
  }

  @override
  void initState() {
    context.read<CategoryCubit>().loadCategories();
    context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    context.read<SearchInternetPackageBloc>().add(
      OnResetInternetPackageEvent(),
    );
    super.initState();
  }

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(24),
            PackageSearchBar(
              controller: edtSearch,
              onSearchPressed: _search,
              onSubmitted: (_) => _search(),
            ),
            const Gap(12),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryError) {
                    return FailedWidget(height: 400, message: state.message);
                  }
                  if (state is CategoryLoaded) {
                    final categories = context
                        .read<CategoryCubit>()
                        .getCategoriesWithAll();
                    if (categories.length <= 1) {
                      return EmptyWidget(height: 400);
                    }
                    return Column(
                      children: [
                        CategoriesTabBar(
                          categories: categories,
                          selectedIndex: _selectedTabIndex,
                          onTabChanged: (index) =>
                              _onTabChanged(index, categories),
                        ),
                        Gap(16),
                        Expanded(
                          child: _selectedTabIndex == 0
                              ? AllPackagesContent(searchController: edtSearch)
                              : CategoryPackagesContent(
                                  selectedTabIndex: _selectedTabIndex,
                                ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
