import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/home/presentation/widgets/circle_loading_widget.dart';
import 'package:inetagan/features/home/presentation/widgets/text_failure_widget.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/cubit/tabbar_cubit.dart';
import 'package:inetagan/features/internet-package/presentation/pages/corporate_packages_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/family_packages_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/student_packages_page.dart';

class AllPackagesPage extends StatefulWidget {
  const AllPackagesPage({super.key});

  @override
  State<AllPackagesPage> createState() => _AllPackagesPageState();
}

class _AllPackagesPageState extends State<AllPackagesPage> {
  final edtSearch = TextEditingController();

  search() {
    final query = edtSearch.text.trim();
    if (query.isEmpty) return;
    context.read<SearchInternetPackageBloc>().add(
      OnSearchInternetPackageEvent(query: query),
    );
  }

  @override
  void initState() {
    context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    context.read<SearchInternetPackageBloc>().add(
      OnResetInternetPackageEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabbarCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Gap(24),
              buildSearch(),
              const Gap(12),
              BlocBuilder<TabbarCubit, int>(
                builder: (context, state) {
                  final cubit = context.read<TabbarCubit>();
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(cubit.labels.length, (i) {
                                final selected = i == state;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ChoiceChip(
                                    side: BorderSide.none,
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    label: Text(
                                      cubit.labels[i],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selected
                                            ? AppColors.primary
                                            : AppColors.tertiary,
                                      ),
                                    ),
                                    selected: selected,
                                    onSelected: (_) => cubit.change(i),
                                    selectedColor: AppColors.primary.withAlpha(
                                      60,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: switch (state) {
                            0 => buildAllPackagePage(),
                            1 => const StudentPackagesPage(),
                            2 => const FamilyPackagesPage(),
                            3 => const CorporatePackagesPage(),
                            _ => const SizedBox.shrink(),
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAllPackagePage() {
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
            return TextFailureWidget(message: searchState.message);
          }
          if (searchState is SearchInternetPackageSuccess &&
              searchState.data.isNotEmpty) {
            return listPackages(searchState.data);
          }

          // Default to all packages if no search
          return BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
            builder: (context, allState) {
              if (allState is AllInternetPackageLoading) {
                return const CircleLoadingWidget();
              }
              if (allState is AllInternetPackageFailed) {
                return TextFailureWidget(message: allState.message);
              }
              if (allState is AllInternetPackageSuccess) {
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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final package = list[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () => context.goNamed(RouteNames.detail, extra: package),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ExtendedImage.network(
                    AppConstant.imagePackage(package.image),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    handleLoadingProgress: true,
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.failed) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        );
                      }
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return const CircleLoadingWidget();
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        package.idealDevice,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.tertiary,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        package.speed,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
