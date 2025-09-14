import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_validator.dart';
import 'package:inetagan/gen/assets.gen.dart';

class EmailFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailFormFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const Gap(12),
        InputWidget(
          controller: controller,
          hintText: 'tulis email anda',
          keyboardType: TextInputType.emailAddress,
          icon: Assets.icons.mail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: AppValidator.validateEmail,
        ),
      ],
    );
  }
}
