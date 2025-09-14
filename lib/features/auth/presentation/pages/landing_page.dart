import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/gen/assets.gen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthLocalDatasource _localDatasource =
      GetIt.instance<AuthLocalDatasource>();
  bool _isRedirecting = false;

  @override
  void initState() {
    super.initState();
    _handleInitialRedirect();
  }

  Future<void> _handleInitialRedirect() async {
    if (_isRedirecting) return;

    _isRedirecting = true;
    try {
      final route = await _localDatasource.determineRedirectRoute();
      if (route != null && mounted) {
        context.goNamed(route);
      }
    } catch (error) {
      debugPrint('Redirect error : $error');
    } finally {
      if (mounted) {
        setState(() => _isRedirecting = false);
      }
    }
  }

  Future<void> _navigateToSignIn() async {
    try {
      await _localDatasource.markAppAsLauched();
      if (mounted) {
        context.goNamed(RouteNames.signin);
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to navigate: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isRedirecting ? _buildLoadingState() : _buildContent(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
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
        Text(
          'Saatnya beralih ke Fiber, Akses Internet\nSuper cepat dan canggih',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.7,
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: AppColors.tertiary,
          ),
        ),
        const Gap(50),
        ButtonWidget(ontap: _navigateToSignIn, text: 'explore now'),
        const Gap(30),
      ],
    );
  }
}
