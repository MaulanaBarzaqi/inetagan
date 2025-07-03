import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasSuffix;
  final String icon;
  final VoidCallback? onSuffixPressed;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        autovalidateMode: autovalidateMode,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: ColorsConstants.primary,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: hasSuffix
              ? IconButton(
                  onPressed: onSuffixPressed,
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorsConstants.primary,
                  ),
                )
              : null,
          prefixIcon: UnconstrainedBox(
            alignment: const Alignment(0.3, 0),
            child: ImageIcon(
              AssetImage(icon),
              size: 24,
              color: ColorsConstants.primary,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: ColorsConstants.tertiary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
