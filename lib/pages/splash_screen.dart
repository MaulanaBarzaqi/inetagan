import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/widgets/button_primary_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(120),
            Image.asset(
              'assets/img_logo_inetagan.png',
              height: 80,
            ),
            const Gap(15),
            Image.asset(
              'assets/img_splashscreen.png',
              height: 350,
            ),
            const Gap(30),
            const Text(
              "Saatnya Beralih ke Fiber, Akses Internet\nSuper cepat dan Canggih",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.7,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xff6D6C6C),
              ),
            ),
            const Gap(60),
            ButtonPrimary(
              ontap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              text: 'Explore Now',
            ),
            const Gap(30)
          ],
        ),
      ),
    );
  }
}
