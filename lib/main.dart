import 'package:d_session/d_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/firebase_options.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/pages/berlangganan_page.dart';
import 'package:inetagan/pages/detail_berlangganan_page.dart';
import 'package:inetagan/pages/detail_page.dart';
import 'package:inetagan/pages/downgrade_page.dart';
import 'package:inetagan/pages/internet_page.dart';
import 'package:inetagan/pages/signin_page.dart';
import 'package:inetagan/pages/signup_page.dart';
import 'package:inetagan/pages/success_berlangganan_page.dart';
import 'package:inetagan/pages/upgrade_page.dart';

import 'pages/home_page.dart';
import 'pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEFEFF0),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == null) return const SplashScreen();
          return const HomePage();
        },
      ),
      routes: {
        '/home-page': (context) => const HomePage(),
        '/signup': (context) => const SignupPage(),
        '/signin': (context) => const SigninPage(),
        '/paket-internet': (context) => const InternetPage(),
        '/detail-page': (context) {
          String paketId = ModalRoute.of(context)!.settings.arguments as String;
          return DetailPage(paketId: paketId);
        },
        '/berlangganan-page': (context) {
          Internet internet =
              ModalRoute.of(context)!.settings.arguments as Internet;
          return BerlanggananPage(
            internet: internet,
          );
        },
        '/detail-berlangganan-page': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          Internet internet = data['internet'];
          String nama = data['nama'];
          String noWhatsapp = data['noWhatsapp'];
          String nik = data['nik'];
          String alamat = data['alamat'];
          String date = data['date'];
          return DetailBerlanggananPage(
            internet: internet,
            nama: nama,
            noWhatsapp: noWhatsapp,
            nik: nik,
            alamat: alamat,
            date: date,
          );
        },
        '/success-berlangganan-page': (context) {
          Internet internet =
              ModalRoute.of(context)!.settings.arguments as Internet;
          return SuccessBerlanggananPage(internet: internet);
        },
        '/downgrade-page': (context) => const DowngradePage(),
        '/upgrade-page': (context) => const UpgradePage(),
      },
    );
  }
}
