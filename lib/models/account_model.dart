class Account {
  final String uid;
  final String nama;
  final String email;
  Account({
    required this.uid,
    required this.nama,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nama': nama,
      'email': email,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      uid: json['uid'] as String,
      nama: json['nama'] as String,
      email: json['email'] as String,
    );
  }
}
