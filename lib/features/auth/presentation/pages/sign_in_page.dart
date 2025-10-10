import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/components/input_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_validator.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../bloc/sign_in/sign_in_bloc.dart';
import '../widgets/error_dialog.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController edtEmail;
  late final TextEditingController edtPassword;
  final formKey = GlobalKey<FormState>();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    edtEmail = TextEditingController();
    edtPassword = TextEditingController();
  }

  @override
  void dispose() {
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }

  void _sibmitSignIn() {
    if (!formKey.currentState!.validate()) return;
    context.read<SignInBloc>().add(
      OnSignInEvent(email: edtEmail.text, password: edtPassword.text),
    );
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            HomeRoute().go(context);
          }
          if (state is SignInFailed) {
            showDialog(context: context, builder: (_) => ErrorDialog());
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildSignInContent(context, state),
              if (state is SignInLoading) _buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignInContent(BuildContext context, SignInState state) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      children: [
        const Gap(100),
        Assets.images.imgLogoInetagan.image(width: 171, height: 71),
        const Gap(30),
        const _HeaderTitle(),
        const Gap(30),
        _buildForm(context),
        const Gap(40),
        const _SignUpLink(),
        const Gap(40),
        ButtonWidget(
          ontap: state is SignInLoading ? null : _sibmitSignIn,
          text: 'Login',
        ),
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
            obscureText: obscureText,
            hasSuffix: true,
            onSuffixPressed: _toggleObscureText,
          ),
        ],
      ),
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
      'Masuk akun',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: AppColors.primary,
      ),
    );
  }
}

class _SignUpLink extends StatelessWidget {
  const _SignUpLink();

  @override
  Widget build(BuildContext context) {
    return Row(
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
            const SignUpRoute().go(context);
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
    );
  }
}
