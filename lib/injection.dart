import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:inetagan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';
import 'package:inetagan/features/auth/domain/usecases/login_usecase.dart';
import 'package:inetagan/features/auth/domain/usecases/logout_usecase.dart';
import 'package:inetagan/features/auth/domain/usecases/register_usecase.dart';
import 'package:inetagan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator()));
  locator.registerFactory(() => LogoutBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => LoginUsecase(locator()));
  locator.registerLazySingleton(() => RegisterUsecase(locator()));
  locator.registerLazySingleton(() => LogoutUsecase(locator()));

  // repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
      authLocalDatasource: locator(),
    ),
  );

  // datasource
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(),
  );

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
}
