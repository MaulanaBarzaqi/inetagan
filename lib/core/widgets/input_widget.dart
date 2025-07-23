import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/gen/assets.gen.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String hintText;
  final bool obscureText;
  final bool hasSuffix;
  final SvgGenImage icon;
  final VoidCallback? onSuffixPressed;
  final AutovalidateMode? autovalidateMode;
  final TextInputType keyboardType;

  const InputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hasSuffix = false,
    required this.icon,
    this.onSuffixPressed,
    this.validator,
    this.autovalidateMode,
    required this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: hasSuffix
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: onSuffixPressed,
                  icon: obscureText
                      ? Assets.icons.eyeClosed.svg(width: 24, height: 24)
                      : Assets.icons.eye.svg(width: 24, height: 24),
                ),
              )
            : null,
        prefixIcon: UnconstrainedBox(
          alignment: const Alignment(0.3, 0),
          child: icon.svg(width: 24, height: 24),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey[500],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
