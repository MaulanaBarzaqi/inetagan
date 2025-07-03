import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/home/data/datasources/internetplan_local_datasource.dart';
import 'package:inetagan/features/home/data/datasources/internetplan_remote_datasource.dart';
import 'package:inetagan/features/home/data/repositories/internetplan_repository_impl.dart';
import 'package:inetagan/features/home/domain/repositories/internetplan_repository.dart';
import 'package:inetagan/features/home/domain/usecases/get_all_internetplan_usecase.dart';
import 'package:inetagan/features/home/domain/usecases/get_corporate_internetplan_usecase.dart';
import 'package:inetagan/features/home/domain/usecases/get_family_internetplan_usecase.dart';
import 'package:inetagan/features/home/domain/usecases/get_student_internetplan_usecase.dart';
import 'package:inetagan/features/home/domain/usecases/search_internetplan_usecase.dart';
import 'package:inetagan/features/home/presentation/bloc/all_internetplan/all_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/corporate_internetplan/corporate_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/family_internetplan/family_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/search_internetplan/search_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/student_internetplan/student_internetplan_bloc.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_local_datasource.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_remote_datasource.dart';
import 'package:inetagan/features/signin/data/repositories/sign_in_repository_impl.dart';
import 'package:inetagan/features/signin/domain/repositories/sign_in_repository.dart';
import 'package:inetagan/features/signin/domain/usecases/sign_in_usecase.dart';
import 'package:inetagan/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:inetagan/features/signup/data/datasources/sign_up_remote_datasource.dart';
import 'package:inetagan/features/signup/data/repositories/sign_up_repository_impl.dart';
import 'package:inetagan/features/signup/domain/repositories/sign_up_repository.dart';
import 'package:inetagan/features/signup/domain/usecases/sign_up_usecase.dart';
import 'package:inetagan/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => SigninBloc(locator()));
  locator.registerFactory(() => SignupBloc(locator()));
  locator.registerFactory(() => AllInternetplanBloc(locator()));
  locator.registerFactory(() => CorporateInternetplanBloc(locator()));
  locator.registerFactory(() => FamilyInternetplanBloc(locator()));
  locator.registerFactory(() => SearchInternetplanBloc(locator()));
  locator.registerFactory(() => StudentInternetplanBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton(() => SignUpUsecase(locator()));
  locator.registerLazySingleton(() => GetAllInternetplanUsecase(locator()));
  locator.registerLazySingleton(
    () => GetCorporateInternetplanUsecase(locator()),
  );
  locator.registerLazySingleton(() => GetFamilyInternetplanUsecase(locator()));
  locator.registerLazySingleton(() => SearchInternetplanUsecase(locator()));
  locator.registerLazySingleton(() => GetStudentInternetplanUsecase(locator()));

  // repository
  locator.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(
      signInLocalDatasource: locator(),
      signInRemoteDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(signUpRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<InternetplanRepository>(
    () => InternetplanRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );

  // datasource
  locator.registerLazySingleton<SignInRemoteDatasource>(
    () => SignInRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<SignInLocalDatasource>(
    () => SignInLocalDatasourceImpl(),
  );
  locator.registerLazySingleton<SignUpRemoteDatasource>(
    () => SignUpRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<InternetPlanRemoteDatasource>(
    () => InternetplanRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<InternetplanLocalDatasource>(
    () => InternetplanLocalDatasourceImpl(locator()),
  );

  // platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
}
