import 'package:flutter/widgets.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';

class DetailItemWidget extends StatelessWidget {
  final String label;
  final dynamic itemDetail;
  const DetailItemWidget({
    super.key,
    required this.label,
    required this.itemDetail,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDetail = itemDetail is int
        ? AppFormat.longPrice(itemDetail)
        : itemDetail.toString();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.tertiary,
            ),
          ),
          Expanded(
            child: Text(
              formattedDetail,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
