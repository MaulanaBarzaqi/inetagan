// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final String title;
  const ErrorDialog({super.key, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$title Gagal!',
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 30,
            color: AppColors.tertiary.withValues(alpha: 0.4),
          ),
          Gap(10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.tertiary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Tutup',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
