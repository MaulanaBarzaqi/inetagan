import 'dart:developer';

import 'package:d_session/d_session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inetagan/models/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthSource {
  //create account
  static Future<String> signUp(
    String nama,
    String email,
    String password,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Account account = Account(
        uid: credential.user!.uid,
        nama: nama,
        email: email,
      );
      //buat account dan di instance ke collection Users dan disamakan dgn uid dan doc nya
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(account.uid)
          .set(account.toJson());
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      log(e.toString());
      return 'something wrong';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }

  //masuk
  static Future<String> signIn(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //kalo ada akunnya kita simpan account ke dokument Users, dan langsung di casting
      final accountDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(credential.user!.uid)
          .get();
      await DSession.setUser(Map.from(accountDoc.data()!));
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      log(e.toString());
      return 'something wrong';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }
}
