import 'paket_internet_model.dart';

class Pemasangan {
  //uid??
  final String nama;
  final String noWhatsapp;
  final String alamat;
  final String nik;
  final String waktupemasangan;
  final Internet internet;
  Pemasangan({
    required this.nama,
    required this.noWhatsapp,
    required this.alamat,
    required this.nik,
    required this.waktupemasangan,
    required this.internet,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nama': nama,
      'noWhatsapp': noWhatsapp,
      'alamat': alamat,
      'nik': nik,
      'waktupemasangan': waktupemasangan,
      'internet': internet.toJson(),
    };
  }

  factory Pemasangan.fromJson(Map<String, dynamic> json) {
    return Pemasangan(
      nama: json['nama'] as String,
      noWhatsapp: json['noWhatsapp'] as String,
      alamat: json['alamat'] as String,
      nik: json['nik'] as String,
      waktupemasangan: json['waktupemasangan'] as String,
      internet: Internet.fromJson(json['internet'] as Map<String, dynamic>),
    );
  }
}
