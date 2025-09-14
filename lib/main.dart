import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:inetagan/features/category/presentation/cubit/category_cubit.dart';
import 'package:inetagan/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:inetagan/features/home/presentation/cubit/dashboard_cubit.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/get_by_category/get_by_category_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/profile/presentation/cubit/log_out/log_out_cubit.dart';
import 'package:inetagan/features/profile/presentation/cubit/profile/profile_cubit.dart';
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
