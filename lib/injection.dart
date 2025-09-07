import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/home/data/datasources/banner_local_datasource.dart';
import 'package:inetagan/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:inetagan/features/home/data/repositories/banner_repository_impl.dart';
import 'package:inetagan/features/home/domain/repositories/banner_repository.dart';
import 'package:inetagan/features/home/domain/usecases/get_banner_list_usecase.dart';
import 'package:inetagan/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:inetagan/features/internet-package/data/datasources/internet_package_local_datasource.dart';
import 'package:inetagan/features/internet-package/data/datasources/internet_package_remote_datasource.dart';
import 'package:inetagan/features/internet-package/data/repositories/internet_package_repository_impl.dart';
import 'package:inetagan/features/internet-package/domain/repositories/internet_package_repository.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_all_internet_package_usecase.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_corporate_package_usecase.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_family_package_usecase.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_student_package_usecase.dart';
import 'package:inetagan/features/internet-package/domain/usecases/search_internet_package_usecase.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/corporate_package/corporate_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/family_package/family_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/search_internet_package/search_internet_package_bloc.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/student_package/student_package_bloc.dart';
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
import 'package:inetagan/features/subscribe/data/datasources/subscribe_remote_datasource.dart';
import 'package:inetagan/features/subscribe/data/repositories/subscribe_repository_impl.dart';
import 'package:inetagan/features/subscribe/domain/repositories/subscribe_repository.dart';
import 'package:inetagan/features/subscribe/domain/usecases/get_subscription_usecase.dart';
import 'package:inetagan/features/subscribe/domain/usecases/subscribe_usecase.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/get_subscription/get_subscription_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/subscribe/subscribe_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => SigninBloc(locator()));
  locator.registerFactory(() => SignupBloc(locator()));
  locator.registerFactory(() => BannerBloc(locator()));
  locator.registerFactory(() => AllInternetPackageBloc(locator()));
  locator.registerFactory(() => CorporatePackageBloc(locator()));
  locator.registerFactory(() => FamilyPackageBloc(locator()));
  locator.registerFactory(() => StudentPackageBloc(locator()));
  locator.registerFactory(() => SearchInternetPackageBloc(locator()));
  locator.registerFactory(() => SubscribeBloc(locator()));
  locator.registerFactory(() => GetSubscriptionBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton(() => SignUpUsecase(locator()));
  locator.registerLazySingleton(() => GetBannerListUsecase(locator()));
  locator.registerLazySingleton(() => GetAllInternetPackageUsecase(locator()));
  locator.registerLazySingleton(() => GetCorporatePackageUsecase(locator()));
  locator.registerLazySingleton(() => GetFamilyPackageUsecase(locator()));
  locator.registerLazySingleton(() => GetStudentPackageUsecase(locator()));
  locator.registerLazySingleton(() => SearchInternetPackageUsecase(locator()));
  locator.registerLazySingleton(() => SubscribeUsecase(locator()));
  locator.registerLazySingleton(() => GetSubscriptionUsecase(locator()));

  // repository
  locator.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<InternetPackageRepository>(
    () => InternetPackageRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<SubscribeRepository>(
    () => SubscribeRepositoryImpl(remoteDatasource: locator()),
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
  locator.registerLazySingleton<BannerRemoteDatasource>(
    () => BannerRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<BannerLocalDatasource>(
    () => BannerLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<InternetPackageRemoteDatasource>(
    () => InternetPackageRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<InternetPackageLocalDatasource>(
    () => InternetPackageLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<SubscribeRemoteDatasource>(
    () => SubscribeRemoteDatasourceImpl(locator()),
  );

  // platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
