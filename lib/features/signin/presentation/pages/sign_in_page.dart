import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_assets.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/features/signin/presentation/widgets/error_dialog.dart';
import 'package:inetagan/core/widgets/input_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(AppAssets.logo, height: 71, width: 171),
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
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  icon: AppAssets.icEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'email tidak boleh kosong';
                    if (!value.contains('@')) return 'email tidak valid';
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  icon: AppAssets.icPassword,
                  obscureText: obscureText,
                  hasSuffix: true,
                  onSuffixPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password tidak boleh kosong';
                    if (value.length < 6) return 'Minimal 6 karakter';
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
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
                  context.goNamed(RouteNames.signup);
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
          BlocConsumer<SigninBloc, SigninState>(
            listener: (context, state) {
              if (state is SignInSuccess) {
                context.goNamed(RouteNames.home);
              }
              if (state is SignInFailed) {
                // AppResponse.invalidInput(context, state.errorMessage);
                showDialog(context: context, builder: (_) => ErrorDialog());
              }
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ButtonWidget(
                ontap: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SigninBloc>().add(
                    OnSignInEvent(
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
}
