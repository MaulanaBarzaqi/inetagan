import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_validator.dart';
import 'package:inetagan/gen/assets.gen.dart';

class NameFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  const NameFormFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        Gap(12),
        InputWidget(
          controller: controller,
          hintText: 'tulis nama anda',
          keyboardType: TextInputType.name,
          icon: Assets.icons.userRound,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: AppValidator.validateName,
        ),
      ],
    );
  }
}
