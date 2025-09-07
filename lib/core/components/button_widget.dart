// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:inetagan/core/config/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? ontap;
  final String text;
  final bool isLoading;
  const ButtonWidget({
    super.key,
    this.ontap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: ontap == null
          ? AppColors.primary.withValues(alpha: 0.5)
          : AppColors.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: ontap,
        child: SizedBox(
          width: double.infinity,
          height: 53,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
