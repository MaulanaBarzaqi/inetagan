import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/core/config/app.dart';
import 'package:inetagan/core/config/bloc_observer.dart';
import 'package:inetagan/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initLocator();
  runApp(const MyApp());
}
