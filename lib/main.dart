import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:inetagan/features/home/presentation/cubit/dashboard_cubit.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/corporate_package/corporate_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/family_package/family_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/student_package/student_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/cubit/tabbar_cubit.dart';
import 'package:inetagan/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:inetagan/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/get_subscription/get_subscription_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/subscribe/subscribe_bloc.dart';
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
        BlocProvider(create: (_) => DashboardCubit()),
        BlocProvider(create: (_) => TabbarCubit()),
        BlocProvider(create: (_) => locator<SigninBloc>()),
        BlocProvider(create: (_) => locator<SignupBloc>()),
        BlocProvider(create: (_) => locator<BannerBloc>()),
        BlocProvider(create: (_) => locator<AllInternetPackageBloc>()),
        BlocProvider(create: (_) => locator<CorporatePackageBloc>()),
        BlocProvider(create: (_) => locator<FamilyPackageBloc>()),
        BlocProvider(create: (_) => locator<StudentPackageBloc>()),
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
