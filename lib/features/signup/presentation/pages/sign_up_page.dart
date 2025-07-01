import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_assets.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/signin/presentation/widgets/button_widget.dart';
import 'package:inetagan/features/signin/presentation/widgets/error_dialog.dart';
import 'package:inetagan/features/signin/presentation/widgets/input_widget.dart';
import 'package:inetagan/features/signup/presentation/bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    edtName.dispose();
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(AppAssets.logo, height: 71, width: 171),
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
          // Form
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  icon: AppAssets.icUser,
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
                  icon: AppAssets.icMessage,
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
                  icon: AppAssets.icKey,
                  obscureText: obscureText,
                  hasSuffix: true,
                  onSuffixPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ],
            ),
          ),
          const Gap(70),
          BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                context.goNamed(RouteNames.signin);
              } else if (state is SignUpFailed) {
                showDialog(context: context, builder: (_) => ErrorDialog());
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ButtonWidget(
                ontap: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SignupBloc>().add(
                    OnSignUpEvent(
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
                  context.goNamed(RouteNames.signin);
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
}
