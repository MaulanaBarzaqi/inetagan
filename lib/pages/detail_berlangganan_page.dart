import 'package:flutter/material.dart';
import 'package:inetagan/models/paket_internet_model.dart';

class DetailBerlanggananPage extends StatefulWidget {
  const DetailBerlanggananPage({
    super.key,
    required this.internet,
    required this.nama,
    required this.noWhatsapp,
    required this.nik,
    required this.alamat,
    required this.date,
  });
  final Internet internet;
  final String nama;
  final String noWhatsapp;
  final String nik;
  final String alamat;
  final String date;

  @override
  State<DetailBerlanggananPage> createState() => _DetailBerlanggananPageState();
}

class _DetailBerlanggananPageState extends State<DetailBerlanggananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
