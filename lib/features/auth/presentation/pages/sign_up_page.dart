import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/presentation/widgets/dialog_helper.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/components/input_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_validator.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../widgets/error_dialog.dart';
import '../widgets/password_required_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController edtName;
  late final TextEditingController edtEmail;
  late final TextEditingController edtPassword;
  final formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool contains8Length = false;

  @override
  void initState() {
    super.initState();
    edtName = TextEditingController();
    edtEmail = TextEditingController();
    edtPassword = TextEditingController();
  }

  @override
  void dispose() {
    edtName.dispose();
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }

  void _submitSignUp() {
    if (!formKey.currentState!.validate()) return;
    context.read<SignUpBloc>().add(
      OnSignUpEvent(
        name: edtName.text,
        email: edtEmail.text,
        password: edtPassword.text,
      ),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validatePassword(String value) {
    setState(() {
      containsUpperCase = AppValidator.hasUpperCase(value);
      containsLowerCase = AppValidator.hasLowerCase(value);
      containsNumber = AppValidator.hasNumber(value);
      contains8Length = AppValidator.hasMinLength(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            SignInRoute().go(context);
          } else if (state is SignUpFailed) {
            final failure = state.failure;
            if (failure is InvalidInputFailure) {
              DialogHelper.showInvalidInputDialog(context, failure.message);
            } else {
              showDialog(
                context: context,
                builder: (_) =>
                    ErrorDialog(title: 'Sign Up', message: failure.message),
              );
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildSignUpContent(context, state),
              if (state is SignUpLoading) _buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignUpContent(BuildContext context, SignUpState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      children: [
        const Gap(100),
        Assets.images.imgLogoInetagan.image(height: 71, width: 171),
        const Gap(30),
        const _HeaderTitle(),
        const Gap(30),
        _buildForm(context),
        const Gap(12),
        _buildPasswordRequirements(),
        const Gap(30),
        ButtonWidget(
          ontap: state is SignUpLoading ? null : _submitSignUp,
          text: 'Daftar',
        ),
        const Gap(25),
        const _SignInLink(),
        const Gap(30),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            onSuffixPressed: _toggleObscureText,
            onChanged: _validatePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Column(
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
            PasswordRequiredWidget(text: 'Angka', isValid: containsNumber),
            PasswordRequiredWidget(
              text: 'Min. 8 karakter',
              isValid: contains8Length,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Daftar Akun',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: AppColors.primary,
      ),
    );
  }
}

class _SignInLink extends StatelessWidget {
  const _SignInLink();

  @override
  Widget build(BuildContext context) {
    return Row(
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
            // Navigasi Type-Safe ke Sign In
            const SignInRoute().go(context);
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
    );
  }
}
