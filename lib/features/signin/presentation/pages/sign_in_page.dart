import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/widgets/loading_widget.dart';
import 'package:inetagan/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/features/signin/presentation/widgets/error_dialog.dart';
import 'package:inetagan/core/widgets/input_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

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
          Assets.images.imgLogoInetagan.image(width: 171, height: 71),
          const Gap(30),
          Text(
            'Masuk akun',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.primary,
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
                    color: AppColors.primary,
                  ),
                ),
                const Gap(12),
                InputWidget(
                  controller: edtEmail,
                  hintText: 'tulis email anda',
                  keyboardType: TextInputType.emailAddress,
                  icon: Assets.icons.mail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(12),
                InputWidget(
                  controller: edtPassword,
                  hintText: 'tulis password anda',
                  keyboardType: TextInputType.visiblePassword,
                  icon: Assets.icons.lockKeyhole,
                  obscureText: obscureText,
                  hasSuffix: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSuffixPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
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
                  color: AppColors.primary,
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
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(40),
          BlocConsumer<SigninBloc, SigninState>(
            listener: (context, state) {
              if (state is SignInSuccess) {
                context.goNamed(RouteNames.dashboard);
              }
              if (state is SignInFailed) {
                showDialog(context: context, builder: (_) => ErrorDialog());
                // AppResponse.invalidInput(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return LoadingWidget();
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
              color: AppColors.primary,
            ),
          ),

          const Gap(30),
        ],
      ),
    );
  }
}
