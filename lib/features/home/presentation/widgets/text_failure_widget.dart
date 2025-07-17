import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';

class TextFailureWidget extends StatelessWidget {
  const TextFailureWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: AppColors.tertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
