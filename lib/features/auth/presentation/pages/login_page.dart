import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:inetagan/features/auth/presentation/widgets/button_widget.dart';
import 'package:inetagan/features/auth/presentation/widgets/error_dialog.dart';
import 'package:inetagan/features/auth/presentation/widgets/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(
            'assets/images/img_logo_inetagan.png',
            height: 71,
            width: 171,
          ),
          const Gap(30),
          Text(
            'Masuk akun',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(30),
          Text(
            'Email',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(12),
          InputWidget(
            controller: edtEmail,
            hintText: 'tulis email anda',
            icon: 'assets/icons/ic_email.png',
          ),
          const Gap(20),
          Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(12),
          InputWidget(
            controller: edtPassword,
            hintText: 'tulis password anda',
            icon: 'assets/icons/ic_password.png',
            obscureText: obscureText,
            hasSuffix: true,
            onSuffixPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          const Gap(40),
          Row(
            children: [
              Text(
                'Belum Punya Akun? ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorsConstants.primary,
                ),
              ),
              InkWell(
                onTap: () {
                  context.goNamed(RouteNames.register);
                },
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: ColorsConstants.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(40),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                // navigate to homepage
                context.goNamed(RouteNames.home);
              }
              if (state is LoginFailed) {
                showDialog(context: context, builder: (_) => ErrorDialog());
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ButtonWidget(
                ontap: () {
                  context.read<LoginBloc>().add(
                    OnLoginEvent(
                      email: edtEmail.text,
                      password: edtPassword.text,
                    ),
                  );
                },
                text: 'Login',
              );
            },
          ),
          const Gap(35),
          Text(
            'Lupa Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorsConstants.primary,
            ),
          ),

          const Gap(30),
        ],
      ),
    );
  }

  @override
  void dispose() {
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }
}
