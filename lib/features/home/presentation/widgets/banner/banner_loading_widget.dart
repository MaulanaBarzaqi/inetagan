import 'package:flutter/material.dart';

class BannerLoadingWidget extends StatelessWidget {
  const BannerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
