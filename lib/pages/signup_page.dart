import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/sources/auth_source.dart';
import 'package:inetagan/widgets/button_primary_widget.dart';
import 'package:inetagan/widgets/input_widget.dart';

import '../cummons/info.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  buatAkunBaru() {
    if (edtName.text == '') return Info.error('Nama anda masih kosong!');
    if (edtEmail.text == '') return Info.error('Email anda masih kosong!');
    if (edtPassword.text == '') return Info.error('masukan Password anda!');

    Info.netral('Loading...');
    AuthSource.signUp(
      edtName.text,
      edtEmail.text,
      edtPassword.text,
    ).then(
      (message) {
        if (message != 'success') return Info.error(message);
        Info.success('Success Mendaftar');
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacementNamed(context, '/signin');
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
            "Daftar akun",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(30),
          const Text(
            'Nama Lengkap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_user.png',
            hint: 'tulis nama anda',
            editingController: edtName,
          ),
          const Gap(20),
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
            hint: 'tulis password',
            editingController: edtPassword,
            obsecure: true,
          ),
          const Gap(70),
          ButtonPrimary(
            ontap: buatAkunBaru,
            text: 'Daftar',
          ),
          const Gap(45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sudah memiliki Akun? ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6D6C6C),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff50C2C9),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
