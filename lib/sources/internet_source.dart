import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inetagan/models/paket_internet_model.dart';

class InternetSource {
  static Future<List<Internet>?> fetchPaketHemat() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .where('bulanan', isLessThan: 217000)
          .orderBy('bulanan', descending: true);
      //eksekusi
      final queryDocs = await ref.get();
      final list =
          queryDocs.docs.map((doc) => Internet.fromJson(doc.data())).toList();
      return list;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch internet by category murah
  static Future<List<Internet>?> fetchSpesial() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .where('category', isEqualTo: 'Murah');
      //eksekusi
      final queryDocs = await ref.get();
      final list =
          queryDocs.docs.map((doc) => Internet.fromJson(doc.data())).toList();
      return list;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch internet by category keluarga
  static Future<List<Internet>?> fetchKeluarga() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .where('category', isEqualTo: 'Keluarga');
      //eksekusi
      final queryDocs = await ref.get();
      final list =
          queryDocs.docs.map((doc) => Internet.fromJson(doc.data())).toList();
      return list;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch internet by category corporate
  static Future<List<Internet>?> fetchCorporate() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .where('category', isEqualTo: 'Corporate');
      //eksekusi
      final queryDocs = await ref.get();
      final list =
          queryDocs.docs.map((doc) => Internet.fromJson(doc.data())).toList();
      return list;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch internet by category pelajar
  static Future<List<Internet>?> fetchPelajar() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .where('category', isEqualTo: 'Pelajar');
      //eksekusi
      final queryDocs = await ref.get();
      final list =
          queryDocs.docs.map((doc) => Internet.fromJson(doc.data())).toList();
      return list;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch internet detail
  static Future<Internet?> fetchInternet(String internetId) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('paket_internet')
          .doc(internetId);
      //eksekusi
      final doc = await ref.get();
      Internet? internet = doc.exists ? Internet.fromJson(doc.data()!) : null;
      return internet;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
