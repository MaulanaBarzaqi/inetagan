import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../../data/datasources/auth_local_datasource.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthLocalDatasource _localDatasource =
      GetIt.instance<AuthLocalDatasource>();

  bool _isLoadingInitialState = true;

  @override
  void initState() {
    super.initState();
    _handleInitialRedirect();
  }

  Future<void> _handleInitialRedirect() async {
    if (mounted) {
      setState(() => _isLoadingInitialState = true);
    }
    try {
      final routeName = await _localDatasource.determineRedirectRoute();
      if (!mounted) return;
      if (routeName == '/home') {
        const HomeRoute().go(context);
      } else if (routeName == '/signin') {
        const SignInRoute().go(context);
      }
    } catch (error) {
      debugPrint('Redirect error : $error');
    } finally {
      if (mounted) {
        setState(() => _isLoadingInitialState = false);
      }
    }
  }

  Future<void> _navigateToSignIn() async {
    try {
      await _localDatasource.markAppAsLauched();
      if (mounted) {
        const SignInRoute().go(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to navigate: $error")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingInitialState
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        const Gap(100),
        Assets.images.imgLogoInetagan.image(height: 80),
        const Gap(15),
        Assets.images.imgSplashscreen.image(height: 350),
        const Gap(30),
        _IntroText(),
        const Gap(50),
        ButtonWidget(ontap: _navigateToSignIn, text: 'explore now'),
        const Gap(30),
      ],
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Saatnya beralih ke Fiber, Akses Internet\nSuper cepat dan canggih',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.7,
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: AppColors.tertiary,
      ),
    );
  }
}
