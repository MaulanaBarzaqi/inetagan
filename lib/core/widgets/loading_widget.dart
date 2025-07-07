import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? strokeWidth;
  const LoadingWidget({
    super.key,
    this.size = 36.0,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth ?? 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Theme.of(context).primaryColor,
      ),
    );
    return Center(
      child: SizedBox(width: size, height: size, child: indicator),
    );
  }
}
