import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/core/services/fcm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/features.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => BannerBloc(locator()));
  locator.registerFactory(() => CategoryCubit(locator()));
  locator.registerFactory(() => GetByCategoryBloc(locator()));
  locator.registerFactory(() => AllInternetPackageBloc(locator()));
  locator.registerFactory(() => SearchInternetPackageBloc(locator()));
  locator.registerFactory(() => SubscribeBloc(locator()));
  locator.registerFactory(() => GetSubscriptionBloc(locator()));
  locator.registerFactory(() => SignInBloc(locator()));
  locator.registerFactory(() => SignUpBloc(locator()));
  locator.registerFactory(() => ProfileCubit(locator()));
  locator.registerFactory(() => LogOutCubit(locator()));
  locator.registerFactory(
    () => NotificationsCubit(
      deleteNottification: locator(),
      getNotifications: locator(),
      saveNotification: locator(),
    ),
  );

  // usecase
  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton(() => SignUpUsecase(locator()));
  locator.registerLazySingleton(() => GetBannerListUsecase(locator()));
  locator.registerLazySingleton(() => GetAllCategories(locator()));
  locator.registerLazySingleton(() => GetByCategoryUsecase(locator()));
  locator.registerLazySingleton(() => GetAllInternetPackageUsecase(locator()));
  locator.registerLazySingleton(() => SearchInternetPackageUsecase(locator()));
  locator.registerLazySingleton(() => SubscribeUsecase(locator()));
  locator.registerLazySingleton(() => GetSubscriptionUsecase(locator()));
  locator.registerLazySingleton(() => GetProfileUsecase(locator()));
  locator.registerLazySingleton(() => LogOutUsecase(locator()));
  locator.registerLazySingleton(() => GetNotificationsUsecase(locator()));
  locator.registerLazySingleton(() => SaveNotificationUsecase(locator()));
  locator.registerLazySingleton(() => DeleteNotificationUsecase(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
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
    () => SubscribeRepositoryImpl(
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(locator()),
  );

  // datasource
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      client: locator(),
      fcmService: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<BannerRemoteDatasource>(
    () => BannerRemoteDatasourceImpl(
      client: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<BannerLocalDatasource>(
    () => BannerLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<CategoryRemoteDatasource>(
    () => CategoryRemoteDatasourceImpl(
      client: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<CategoryLocalDatasource>(
    () => CategoryLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<InternetPackageRemoteDatasource>(
    () => InternetPackageRemoteDatasourceImpl(
      client: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<InternetPackageLocalDatasource>(
    () => InternetPackageLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<SubscribeRemoteDatasource>(
    () => SubscribeRemoteDatasourceImpl(
      client: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<SubscribeLocalDatasource>(
    () => SubscribeLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(
      client: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<NotificationLocalDatasource>(
    () => NotificationLocalDatasourceImpl(locator()),
  );

  // service fcm
  locator.registerLazySingleton(() => FcmService());
  // platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
