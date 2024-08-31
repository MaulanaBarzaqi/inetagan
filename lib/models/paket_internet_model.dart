class Internet {
  final String paketId;
  final String nama;
  final String image;
  final String kecepatan;
  final String category;
  final String idealDevices;
  final num bulanan;
  final num pemasangan;
  final num price;
  Internet({
    required this.paketId,
    required this.nama,
    required this.image,
    required this.kecepatan,
    required this.category,
    required this.idealDevices,
    required this.bulanan,
    required this.pemasangan,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'paketId': paketId,
      'nama': nama,
      'image': image,
      'kecepatan': kecepatan,
      'category': category,
      'idealDevices': idealDevices,
      'bulanan': bulanan,
      'pemasangan': pemasangan,
      'price': price,
    };
  }

  factory Internet.fromJson(Map<String, dynamic> json) {
    return Internet(
      paketId: json['paketId'] as String,
      nama: json['nama'] as String,
      image: json['image'] as String,
      kecepatan: json['kecepatan'] as String,
      category: json['category'] as String,
      idealDevices: json['idealDevices'] as String,
      bulanan: json['bulanan'] as num,
      pemasangan: json['pemasangan'] as num,
      price: json['price'] as num,
    );
  }
  static Internet get empty => Internet(
        paketId: '',
        nama: '',
        image: '',
        kecepatan: '',
        category: '',
        idealDevices: '',
        bulanan: 0,
        pemasangan: 0,
        price: 0,
      );
}
