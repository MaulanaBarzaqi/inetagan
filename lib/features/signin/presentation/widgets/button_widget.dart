import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const ButtonWidget({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: ColorsConstants.primary,
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
