import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:inetagan/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<LoginBloc>()),
        BlocProvider(create: (_) => locator<RegisterBloc>()),
        BlocProvider(create: (_) => locator<LogoutBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: Color(0xffEFEFF0),
        ),
      ),
    );
  }
}
