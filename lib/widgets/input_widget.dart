import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.icon,
    required this.hint,
    required this.editingController,
    this.obsecure,
    this.enable = true,
    this.ontapBox,
  });
  final String icon;
  final String hint;
  final TextEditingController editingController;
  final bool? obsecure;
  final bool enable;
  final VoidCallback? ontapBox;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapBox,
      child: TextField(
        controller: editingController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff50C2C9),
        ),
        obscureText: obsecure ?? false,
        decoration: InputDecoration(
            enabled: enable,
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                width: 2,
                color: Color(0xff50C2C9),
              ),
            ),
            prefixIcon: UnconstrainedBox(
              alignment: const Alignment(0.5, 0),
              child: Image.asset(
                icon,
                height: 24,
                width: 24,
              ),
            )),
      ),
    );
  }
}
