import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/gen/assets.gen.dart';

class DetailItemWidget extends StatelessWidget {
  final String label;
  final dynamic detail;
  const DetailItemWidget({
    super.key,
    required this.label,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDetail = detail is int
        ? AppFormat.longPrice(detail)
        : detail.toString();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      height: 52,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          Assets.icons.squareCheckBig.svg(width: 24, height: 24),
          Gap(15),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.tertiary,
            ),
          ),
          Gap(5),
          Text(
            formattedDetail,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
