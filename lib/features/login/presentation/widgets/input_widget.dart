// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:inetagan/constants/colors_constant.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasSuffix;
  final String icon;
  final VoidCallback? onSuffixPressed;
  const InputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hasSuffix = false,
    this.onSuffixPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
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
