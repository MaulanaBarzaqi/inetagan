import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
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
  // signIn
  locator.registerFactory(() => SigninBloc(locator()));
  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(
      signInLocalDatasource: locator(),
      signInRemoteDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<SignInRemoteDatasource>(
    () => SignInRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<SignInLocalDatasource>(
    () => SignInLocalDatasourceImpl(),
  );

  // signUp
  locator.registerFactory(() => SignupBloc(locator()));
  locator.registerLazySingleton(() => SignUpUsecase(locator()));
  locator.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(signUpRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<SignUpRemoteDatasource>(
    () => SignUpRemoteDatasourceImpl(locator()),
  );

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
}
