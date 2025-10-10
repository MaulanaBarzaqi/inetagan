import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../internet-package/domain/entities/internet_package_entity.dart';
import '../../../../internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import '../../../../internet-package/presentation/widgets/package_widget.dart';
import 'package_special_item_widget.dart';

class HomeSpecialSection extends StatelessWidget {
  const HomeSpecialSection({super.key});

  static const double sectionHeight = 295;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Paket Special',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
        ),
        Gap(10),
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
              final specialPackages = list.take(4).toList();
              if (list.isEmpty) {
                return EmptyWidget(height: sectionHeight);
              }
              return SizedBox(
                height: sectionHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: specialPackages.length,
                  itemBuilder: (context, index) {
                    return PackageSpecialItemWidget(
                      package: specialPackages[index],
                      index: index,
                      total: specialPackages.length,
                    );
                  },
                ),
              );
            }
            return SizedBox(
              height: sectionHeight,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          },
        ),
      ],
    );
  }
}
