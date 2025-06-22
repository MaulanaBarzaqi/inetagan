import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:inetagan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:inetagan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';
import 'package:inetagan/features/auth/domain/usecases/login_usecase.dart';
import 'package:inetagan/features/auth/domain/usecases/register_usecase.dart';
import 'package:inetagan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:inetagan/features/auth/presentation/bloc/register/register_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => LoginUsecase(locator()));
  locator.registerLazySingleton(() => RegisterUsecase(locator()));

  // repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: locator()),
  );

  // datasource
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(locator()),
  );

  // external
  locator.registerLazySingleton<Dio>(() => Dio());
}
