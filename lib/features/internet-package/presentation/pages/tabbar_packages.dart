import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/cubit/tabbar_cubit.dart';

class TabbarPackages extends StatefulWidget {
  const TabbarPackages({super.key});

  @override
  State<TabbarPackages> createState() => _TabbarPackagesState();
}

class _TabbarPackagesState extends State<TabbarPackages> {
  final edtSearch = TextEditingController();

  search() {
    if (edtSearch.text == '') return;
    context.read<SearchInternetPackageBloc>().add(
      OnSearchInternetPackageEvent(query: edtSearch.text),
    );
  }

  @override
  void initState() {
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
                                    avatar: null,
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
                        Expanded(child: cubit.pages[state]),
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

  buildSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: edtSearch,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cari paket internet...',
                hintStyle: TextStyle(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Gap(10),
          IconButton.filledTonal(
            onPressed: () => search(),
            icon: Icon(Icons.search, size: 24),
          ),
        ],
      ),
    );
  }

  //  PR
  // untuk search nya buat search page sendiri saja :)
  // optional: bikin icon filter di samping search berdasarkan kategory
}
