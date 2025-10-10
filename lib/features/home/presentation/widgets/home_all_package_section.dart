import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_colors.dart';
import '../../../internet-package/domain/entities/internet_package_entity.dart';
import '../../../internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import '../../../internet-package/presentation/widgets/package_widget.dart';

class HomeAllPackageSection extends StatelessWidget {
  const HomeAllPackageSection({super.key});

  static const double sectionHeight = 200;

  static const int maxItems = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Paket Internet",
                style: TextStyle(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
            builder: (context, state) {
              if (state is AllInternetPackageLoading) {
                return SizedBox(
                  height: sectionHeight,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              if (state is AllInternetPackageFailed) {
                return FailedWidget(
                  height: sectionHeight,
                  message: state.message,
                );
              }
              if (state is AllInternetPackageSuccess) {
                List<InternetPackageEntity> list = state.data;
                final allPackages = list.take(maxItems).toList();
                // Jika tidak ada data package
                if (list.isEmpty) {
                  return EmptyWidget(height: sectionHeight);
                }
                return ListView.builder(
                  itemCount: allPackages.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PackageListItemWidget(package: list[index]);
                  },
                );
              }
              return SizedBox(
                height: sectionHeight,
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            },
          ),
        ],
      ),
    );
  }
}
