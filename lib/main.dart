import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/home/presentation/bloc/all_internetplan/all_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/corporate_internetplan/corporate_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/family_internetplan/family_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/search_internetplan/search_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/student_internetplan/student_internetplan_bloc.dart';
import 'package:inetagan/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:inetagan/features/signup/presentation/bloc/signup_bloc.dart';
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
        BlocProvider(create: (_) => locator<SigninBloc>()),
        BlocProvider(create: (_) => locator<SignupBloc>()),
        BlocProvider(create: (_) => locator<AllInternetplanBloc>()),
        BlocProvider(create: (_) => locator<CorporateInternetplanBloc>()),
        BlocProvider(create: (_) => locator<FamilyInternetplanBloc>()),
        BlocProvider(create: (_) => locator<SearchInternetplanBloc>()),
        BlocProvider(create: (_) => locator<StudentInternetplanBloc>()),
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
