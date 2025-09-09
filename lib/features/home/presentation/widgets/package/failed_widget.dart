import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';

class FailedWidget extends StatelessWidget {
  final double height;
  final String message;

  const FailedWidget({super.key, required this.height, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 40, color: Colors.grey),
            Gap(8),
            Text(
              message,
              style: TextStyle(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
