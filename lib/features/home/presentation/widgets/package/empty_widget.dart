import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyWidget extends StatelessWidget {
  final double height;
  const EmptyWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_off, size: 40, color: Colors.grey),
          Gap(8),
          Text('Tidak ada paket', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
