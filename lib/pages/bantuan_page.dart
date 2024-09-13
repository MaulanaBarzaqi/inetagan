// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BantuanPage extends StatefulWidget {
  const BantuanPage({
    super.key,
    required this.uid,
    required this.userName,
  });
  final String uid;
  final String userName;

  @override
  State<BantuanPage> createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
