import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({super.key, required this.ontap, required this.text});
  final VoidCallback ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xff50C2C9),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: ontap,
        child: SizedBox(
          width: double.infinity,
          height: 53,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
