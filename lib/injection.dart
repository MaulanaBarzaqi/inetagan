import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:inetagan/features/login/data/datasources/login_remote_datasource.dart';
import 'package:inetagan/features/login/data/repositories/login_repository_impl.dart';
import 'package:inetagan/features/login/domain/repositories/login_repository.dart';
import 'package:inetagan/features/login/domain/usecases/login_usecase.dart';
import 'package:inetagan/features/login/presentation/bloc/login_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => LoginUsecase(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(loginRemoteDataSource: locator()),
  );

  // datasource
  locator.registerLazySingleton<LoginRemoteDatasource>(
    () => LoginRemoteDatasourceImpl(locator()),
  );

  // external
  locator.registerLazySingleton<Dio>(() => Dio());
}
