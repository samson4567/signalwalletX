import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/app_bloc/data/datasources/app_local_datasource.dart';
import 'package:signalwavex/features/app_bloc/data/datasources/app_remote_datasource.dart';
import 'package:signalwavex/features/app_bloc/data/repositories/app_repository_impl.dart';
import 'package:signalwavex/features/app_bloc/domain/repositories/app_repository.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:signalwavex/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  // Register AppPreferenceService as an async singleton
  getItInstance.registerSingletonAsync<AppPreferenceService>(() async {
    final service = AppPreferenceService();
    await service.init();
    return service;
  });

  await getItInstance.isReady<AppPreferenceService>();

  getItInstance.registerLazySingleton<Dio>(() => Dio());

  getItInstance.registerLazySingleton<SignalWalletNetworkClient>(() =>
      SignalWalletNetworkClient(
          dio: getItInstance<Dio>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));
  // AppBloc
  getItInstance.registerLazySingleton<AppRemoteDatasource>(() =>
      AppRemoteDatasourceImpl(
          networkClient: getItInstance<SignalWalletNetworkClient>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<AppLocalDatasource>(() =>
      AppLocalDatasourceImpl(
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
      appRemoteDatasource: getItInstance<AppRemoteDatasource>(),
      appLocalDatasource: getItInstance<AppLocalDatasource>()));

  getItInstance.registerLazySingleton<AppBloc>(
      () => AppBloc(appRepository: getItInstance<AppRepository>()));
  // AppBloc Ended......

// AuthBloc ......
  getItInstance.registerLazySingleton<AuthenticationRemoteDatasource>(() =>
      AuthenticationRemoteDatasourceImpl(
          networkClient: getItInstance<SignalWalletNetworkClient>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<AuthenticationLocalDatasource>(() =>
      AuthenticationLocalDatasourceImpl(
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationRemoteDatasource:
              getItInstance<AuthenticationRemoteDatasource>(),
          authenticationLocalDatasource:
              getItInstance<AuthenticationLocalDatasource>()));

  getItInstance.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
        authenticationRepository: getItInstance<AuthenticationRepository>(),
        appBloc: getItInstance<AppBloc>()),
  );
  // AuthBloc Ended......
}
