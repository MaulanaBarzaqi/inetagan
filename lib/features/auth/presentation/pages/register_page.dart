import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:inetagan/features/auth/presentation/widgets/button_widget.dart';
import 'package:inetagan/features/auth/presentation/widgets/error_dialog.dart';
import 'package:inetagan/features/auth/presentation/widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(
            'assets/images/img_logo_inetagan.png',
            height: 71,
            width: 171,
          ),
          const Gap(30),
          Text(
            'Daftar Akun',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(30),
          // name
          Text(
            'Nama',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(12),
          InputWidget(
            controller: edtName,
            hintText: 'tulis nama anda',
            icon: 'assets/icons/ic_user.png',
          ),
          const Gap(20),
          // email
          Text(
            'Email',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(12),
          InputWidget(
            controller: edtEmail,
            hintText: 'tulis email anda',
            icon: 'assets/icons/ic_message.png',
          ),
          const Gap(20),
          // password
          Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorsConstants.primary,
            ),
          ),
          const Gap(12),
          InputWidget(
            controller: edtPassword,
            hintText: 'tulis password anda',
            icon: 'assets/icons/ic_key.png',
            obscureText: obscureText,
            hasSuffix: true,
            onSuffixPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          const Gap(70),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.goNamed(RouteNames.login);
              } else if (state is RegisterFailed) {
                showDialog(context: context, builder: (_) => ErrorDialog());
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ButtonWidget(
                ontap: () {
                  context.read<RegisterBloc>().add(
                    OnRegisterEvent(
                      name: edtName.text,
                      email: edtEmail.text,
                      password: edtPassword.text,
                    ),
                  );
                },
                text: 'Daftar',
              );
            },
          ),
          Gap(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'sudah memiliki akun? ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorsConstants.primary,
                ),
              ),
              InkWell(
                onTap: () {
                  context.goNamed(RouteNames.login);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: ColorsConstants.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(30),
        ],
      ),
    );
  }

  @override
  void dispose() {
    edtName.dispose();
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }
}
