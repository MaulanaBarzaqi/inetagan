import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/gen/assets.gen.dart';

class BuildInfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final SvgGenImage? icon;
  const BuildInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          icon!.svg(width: 20, height: 20),
          Gap(12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
