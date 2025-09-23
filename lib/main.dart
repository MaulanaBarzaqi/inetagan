import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/core/config/app.dart';
import 'package:inetagan/core/config/bloc_observer.dart';
import 'package:inetagan/core/services/fcm_service.dart';
import 'package:inetagan/firebase_options.dart';
import 'package:inetagan/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmService = FcmService();
  await fcmService.setupListeners();
  runApp(const MyApp());
}
