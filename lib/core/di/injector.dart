import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerSingletonAsync<AppPreferenceService>(() async {
    final service = AppPreferenceService();
    await service.init();
    return service;
  });

  getItInstance.registerLazySingleton(() => Dio());
  getItInstance.registerLazySingleton(() => SignalWalletNetworkClient(
      dio: getItInstance(), appPreferenceService: getItInstance()));

  // getItInstance.registerLazySingleton<AuthenticationRemoteDatasource>(
  //         () => AuthenticationRemoteDatasourceImpl(networkClient: getItInstance()));
  // getItInstance.registerLazySingleton<AuthenticationLocalDatasource>(
  //         () => AuthenticationLocalDatasourceImpl(appPreferenceService: getItInstance()));
  // getItInstance.registerLazySingleton<AuthenticationRepository>(
  //         () => AuthenticationRepositoryImpl(
  //         authenticationRemoteDatasource: getItInstance(),
  //         authenticationLocalDatasource: getItInstance()));

  // getItInstance.registerLazySingleton(
  //     ()=> AuthBloc(authenticationRepository: getItInstance()));
}
