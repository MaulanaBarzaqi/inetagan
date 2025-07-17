import 'package:flutter/material.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.internetPackage});
  final InternetPackageEntity internetPackage;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
