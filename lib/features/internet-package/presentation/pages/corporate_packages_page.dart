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
import 'package:inetagan/features/internet-package/presentation/bloc/corporate_package/corporate_package_bloc.dart';

class CorporatePackagesPage extends StatefulWidget {
  const CorporatePackagesPage({super.key});

  @override
  State<CorporatePackagesPage> createState() => _CorporatePackagesPageState();
}

class _CorporatePackagesPageState extends State<CorporatePackagesPage> {
  refresh() {
    context.read<CorporatePackageBloc>().add(OnCorporatePackageEvent());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: BlocBuilder<CorporatePackageBloc, CorporatePackageState>(
        builder: (context, state) {
          if (state is CorporatePackageLoading) {
            return CircleLoadingWidget();
          }
          if (state is CorporatePackageFailed) {
            return TextFailureWidget(message: state.message);
          }
          if (state is CorporatePackageSuccess) {
            List<InternetPackageEntity> list = state.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                itemCount: state.data.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  InternetPackageEntity internetPackage = list[index];
                  return itemPackages(internetPackage);
                },
              ),
            );
          }
          return SizedBox(height: 120);
        },
      ),
    );
  }

  itemPackages(InternetPackageEntity package) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
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
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                        child: const CircleLoadingWidget(),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: TextStyle(
                      color: AppColors.secondary,
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
                  Text(
                    package.idealDevice,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1,
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                  ),
                  Gap(10),
                  Text(
                    package.speed,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1,
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
  }
}
