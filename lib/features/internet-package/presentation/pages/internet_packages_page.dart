import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';

class InternetPackagesPage extends StatelessWidget {
  const InternetPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [search()]));
  }

  search() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cari paket internet...',
                hintStyle: TextStyle(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.all(0),
              ),
            ),
          ),
          Gap(10),
          IconButton.filledTonal(
            onPressed: () {},
            icon: Icon(Icons.search, size: 24),
          ),
        ],
      ),
    );
  }
}
