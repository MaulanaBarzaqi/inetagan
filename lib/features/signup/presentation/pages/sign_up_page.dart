import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/features/signin/presentation/widgets/error_dialog.dart';
import 'package:inetagan/core/widgets/input_widget.dart';
import 'package:inetagan/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:inetagan/gen/assets.gen.dart';

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

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool contains8Length = false;

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
          Assets.images.imgLogoInetagan.image(height: 71, width: 171),
          const Gap(30),
          Text(
            'Daftar Akun',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.primary,
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
                    color: AppColors.primary,
                  ),
                ),
                const Gap(12),
                InputWidget(
                  controller: edtName,
                  hintText: 'tulis nama anda',
                  keyboardType: TextInputType.name,
                  icon: Assets.icons.userRound,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (value.length > 30) {
                      return 'Name too long';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                // email
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(12),
                InputWidget(
                  controller: edtEmail,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'tulis email anda',
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
                // password
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(12),
                InputWidget(
                  controller: edtPassword,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'tulis password anda',
                  icon: Assets.icons.lockKeyhole,
                  obscureText: obscureText,
                  hasSuffix: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSuffixPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  onChanged: (val) {
                    if (val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (val.length >= 8) {
                      setState(() {
                        contains8Length = true;
                      });
                    } else {
                      setState(() {
                        contains8Length = false;
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  1 uppercase",
                          style: TextStyle(
                            color: containsUpperCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "⚈  1 lowercase",
                          style: TextStyle(
                            color: containsLowerCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "⚈  1 number",
                          style: TextStyle(
                            color: containsNumber
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  8 minimum character",
                          style: TextStyle(
                            color: contains8Length
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  color: AppColors.primary,
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
                    color: AppColors.primary,
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
