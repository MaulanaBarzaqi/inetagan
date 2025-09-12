import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';
import 'package:inetagan/features/category/presentation/cubit/category_cubit.dart';
import 'package:inetagan/features/category/presentation/pages/categories_tab_bar.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/get_by_category/get_by_category_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_widget.dart';

class AllPackagesPage extends StatefulWidget {
  const AllPackagesPage({super.key});

  @override
  State<AllPackagesPage> createState() => _AllPackagesPageState();
}

class _AllPackagesPageState extends State<AllPackagesPage> {
  final edtSearch = TextEditingController();
  int _selectedTabIndex = 0;

  void search() {
    final query = edtSearch.text.trim();
    if (query.isEmpty) return;
    context.read<SearchInternetPackageBloc>().add(
      OnSearchInternetPackageEvent(query: query),
    );
  }

  void _onTabChanged(int index, List<CategoryEntity> categories) {
    setState(() => _selectedTabIndex = index);
    final selectedCategory = categories[index];

    if (selectedCategory.slug == 'all') {
      context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    } else {
      context.read<GetByCategoryBloc>().add(
        OnGetByCategoryEvent(selectedCategory.slug),
      );
    }
    context.read<SearchInternetPackageBloc>().add(
      OnResetInternetPackageEvent(),
    );
    edtSearch.clear();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(24),
            buildSearch(),
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
                        Expanded(child: _buildContent()),
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

  Widget _buildContent() {
    if (_selectedTabIndex == 0) {
      return _buildAllPackagePage();
    } else {
      return _buildCategoryPackagePage();
    }
  }

  Widget _buildAllPackagePage() {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
        context.read<SearchInternetPackageBloc>().add(
          OnResetInternetPackageEvent(),
        );
      },
      child: BlocBuilder<SearchInternetPackageBloc, SearchInternetPackageState>(
        builder: (context, searchState) {
          if (searchState is SearchInternetPackageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (searchState is SearchInternetPackageFailed) {
            return FailedWidget(height: 300, message: searchState.message);
          }
          if (searchState is SearchInternetPackageSuccess) {
            if (searchState.data.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 50, color: Colors.grey),
                  Gap(16),
                  Text(
                    'tidak ditemukan paket dengan kata kunci "${edtSearch.text}"',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      edtSearch.clear();
                      context.read<SearchInternetPackageBloc>().add(
                        OnResetInternetPackageEvent(),
                      );
                    },
                    child: const Text('Reset Pencarian'),
                  ),
                ],
              );
            }
            return listPackages(searchState.data);
          }

          // Default to all packages if no search
          return BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
            builder: (context, allState) {
              if (allState is AllInternetPackageLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (allState is AllInternetPackageFailed) {
                return FailedWidget(height: 300, message: allState.message);
              }
              if (allState is AllInternetPackageSuccess) {
                if (allState.data.isEmpty) {
                  return EmptyWidget(height: 300);
                }
                return listPackages(allState.data);
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget listPackages(List<InternetPackageEntity> list) {
    if (list.isEmpty) {
      return EmptyWidget(height: 300);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final package = list[index];
        return ItemListPackageWidget(package: package);
      },
    );
  }

  Widget _buildCategoryPackagePage() {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        final categories = context.read<CategoryCubit>().getCategoriesWithAll();
        final selectedCategory = categories[_selectedTabIndex];
        context.read<GetByCategoryBloc>().add(
          OnGetByCategoryEvent(selectedCategory.slug),
        );
      },
      child: BlocBuilder<GetByCategoryBloc, GetByCategoryState>(
        builder: (context, state) {
          if (state is GetByCategoryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetByCategoryFailed) {
            return FailedWidget(height: 300, message: state.message);
          }
          if (state is GetByCategorySuccess) {
            if (state.data.isEmpty) {
              return EmptyWidget(height: 300);
            }
            return listPackages(state.data);
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: edtSearch,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cari paket internet...',
              ),
            ),
          ),
          const Gap(10),
          IconButton.filledTonal(
            onPressed: () => search(),
            icon: const Icon(Icons.search, size: 24),
          ),
        ],
      ),
    );
  }
}
