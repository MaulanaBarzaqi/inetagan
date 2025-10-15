import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/injection.dart';
import 'package:inetagan/routes/app_router.dart';
import '../../features/features.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<NotificationsCubit>()),
        BlocProvider(create: (_) => locator<ProfileCubit>()),
        BlocProvider(create: (_) => locator<LogOutCubit>()),
        BlocProvider(create: (_) => locator<SignInBloc>()),
        BlocProvider(create: (_) => locator<SignUpBloc>()),
        BlocProvider(create: (_) => locator<CategoryCubit>()),
        BlocProvider(create: (_) => locator<GetByCategoryBloc>()),
        BlocProvider(create: (_) => locator<BannerBloc>()),
        BlocProvider(create: (_) => locator<AllInternetPackageBloc>()),
        BlocProvider(create: (_) => locator<SearchInternetPackageBloc>()),
        BlocProvider(create: (_) => locator<SubscribeBloc>()),
        BlocProvider(create: (_) => locator<GetSubscriptionBloc>()),
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
