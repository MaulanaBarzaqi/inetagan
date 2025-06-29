import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/auth/presentation/bloc/logout/logout_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.goNamed(RouteNames.login);
              } else if (state is LogoutFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: ${state.message}')),
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<LogoutBloc>().add(OnLogoutEvent());
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to Home Page', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
