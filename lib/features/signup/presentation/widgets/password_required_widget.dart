// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';

class PasswordRequiredWidget extends StatelessWidget {
  final String text;
  final bool isValid;
  const PasswordRequiredWidget({
    super.key,
    required this.text,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isValid ? AppColors.primary : AppColors.tertiary,
        ),
        Gap(6),
        Text(
          text,
          style: TextStyle(
            color: isValid ? AppColors.primary : AppColors.tertiary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
