import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_validator.dart';
import 'package:inetagan/gen/assets.gen.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const PasswordFormFieldWidget({super.key, required this.controller});

  @override
  State<PasswordFormFieldWidget> createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const Gap(12),
        InputWidget(
          controller: widget.controller,
          hintText: 'tulis password anda',
          keyboardType: TextInputType.visiblePassword,
          icon: Assets.icons.lockKeyhole,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: AppValidator.validatePassword,
          obscureText: _obscureText,
          hasSuffix: true,
          onSuffixPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ],
    );
  }
}
