import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_validator.dart';
import 'package:inetagan/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:inetagan/features/auth/presentation/widgets/error_dialog.dart';
import 'package:inetagan/features/auth/presentation/widgets/password_required_widget.dart';
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
  bool _obscureText = true;

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
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.goNamed(RouteNames.signin);
          } else if (state is SignUpFailed) {
            showDialog(context: context, builder: (_) => ErrorDialog());
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 0,
                ),
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
                        // NameFormFieldWidget(controller: edtName),
                        InputWidget(
                          label: 'Nama',
                          controller: edtName,
                          hintText: 'tulis nama anda',
                          icon: Assets.icons.userRound,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: AppValidator.validateName,
                        ),
                        const Gap(20),
                        // email
                        // EmailFormFieldWidget(controller: edtEmail),
                        InputWidget(
                          label: 'Email',
                          controller: edtEmail,
                          hintText: 'tulis email anda',
                          icon: Assets.icons.mail,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: AppValidator.validateEmail,
                        ),
                        const Gap(20),
                        // password
                        InputWidget(
                          label: 'Password',
                          controller: edtPassword,
                          hintText: 'tulis password anda',
                          icon: Assets.icons.lockKeyhole,
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: AppValidator.validatePassword,
                          obscureText: _obscureText,
                          hasSuffix: true,
                          onSuffixPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              containsUpperCase = AppValidator.hasUpperCase(
                                value,
                              );
                              containsLowerCase = AppValidator.hasLowerCase(
                                value,
                              );
                              containsNumber = AppValidator.hasNumber(value);
                              contains8Length = AppValidator.hasMinLength(
                                value,
                              );
                            });
                          },
                        ),
                        // PasswordFormFieldWidget(
                        //   controller: edtPassword,
                        //   onChanged: (val) {
                        //     setState(() {
                        // containsUpperCase = AppValidator.hasUpperCase(
                        //   val,
                        // );
                        // containsLowerCase = AppValidator.hasLowerCase(
                        //   val,
                        // );
                        // containsNumber = AppValidator.hasNumber(val);
                        // contains8Length = AppValidator.hasMinLength(val);
                        //     });
                        //   },
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(12),
                            Text(
                              "Password harus mengandung :",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gap(8),
                            Wrap(
                              spacing: 20,
                              runSpacing: 6,
                              children: [
                                PasswordRequiredWidget(
                                  text: 'Huruf Besar',
                                  isValid: containsUpperCase,
                                ),
                                PasswordRequiredWidget(
                                  text: 'huruf Kecil',
                                  isValid: containsLowerCase,
                                ),
                                PasswordRequiredWidget(
                                  text: 'Angka',
                                  isValid: containsNumber,
                                ),
                                PasswordRequiredWidget(
                                  text: 'Min. 8 karakter',
                                  isValid: contains8Length,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  ButtonWidget(
                    ontap: state is SignUpLoading
                        ? null
                        : () {
                            if (!formKey.currentState!.validate()) return;
                            context.read<SignUpBloc>().add(
                              OnSignUpEvent(
                                name: edtName.text,
                                email: edtEmail.text,
                                password: edtPassword.text,
                              ),
                            );
                          },
                    text: 'Daftar',
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
              if (state is SignUpLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
