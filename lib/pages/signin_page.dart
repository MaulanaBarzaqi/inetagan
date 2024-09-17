import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/cummons/info.dart';
import 'package:inetagan/sources/auth_source.dart';
import 'package:inetagan/widgets/button_primary_widget.dart';
import 'package:inetagan/widgets/input_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  masukAkun() {
    if (edtEmail.text == '') return Info.error('email anda masih kosong!');
    if (edtPassword.text == '') return Info.error('masukan password anda!');

    Info.netral('Loading...');
    AuthSource.signIn(
      edtEmail.text,
      edtPassword.text,
    ).then(
      (message) {
        if (message != 'success') return Info.error(message);
        Info.success('Success Masuk');
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacementNamed(context, '/home-page');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(
            'assets/img_logo_inetagan.png',
            height: 71,
            width: 171,
          ),
          const Gap(30),
          const Text(
            "Masuk akun",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(30),
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_message.png',
            hint: 'tulis email anda',
            editingController: edtEmail,
          ),
          const Gap(20),
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_key.png',
            hint: 'tulis password anda',
            editingController: edtPassword,
            obsecure: true,
          ),
          const Gap(40),
          Row(
            children: [
              const Text(
                'Belum memiliki Akun? ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6D6C6C),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff50C2C9),
                  ),
                ),
              ),
            ],
          ),
          const Gap(40),
          ButtonPrimary(
            ontap: masukAkun,
            text: 'Login',
          ),
          const Gap(35),
          InkWell(
            onTap: () {},
            child: const Text(
              'Lupa Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff6D6C6C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
