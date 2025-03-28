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
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_local_datasource.dart';
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_remote_datasource.dart';
import 'package:signalwavex/features/trading_system/data/repositories/trading_system_repository_impl.dart';
import 'package:signalwavex/features/trading_system/domain/repositories/trading_system_repository.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/user/data/datasources/user_local_datasource.dart';
import 'package:signalwavex/features/user/data/datasources/user_remote_datasource.dart';
import 'package:signalwavex/features/user/data/repositories/user_repository_impl.dart';
import 'package:signalwavex/features/user/domain/repositories/user_repository.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/datasources/wallet_system_user_balance_and_trade_calling_local_datasource.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/datasources/wallet_system_user_balance_and_trade_calling_remote_datasource.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/repositories/wallet_system_user_balance_and_trade_calling_repository_impl.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/repositories/wallet_system_user_balance_and_trade_calling_repository.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';

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

  // wallet_system_user_balance_and_trade_calling Bloc ......
  getItInstance.registerLazySingleton<
          WalletSystemUserBalanceAndTradeCallingRemoteDatasource>(
      () => WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl(
          networkClient: getItInstance<SignalWalletNetworkClient>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<
          WalletSystemUserBalanceAndTradeCallingLocalDatasource>(
      () => WalletSystemUserBalanceAndTradeCallingLocalDatasourceImpl(
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<
          WalletSystemUserBalanceAndTradeCallingRepository>(
      () => WalletSystemUserBalanceAndTradeCallingRepositoryImpl(
          walletSystemUserBalanceAndTradeCallingLocalDatasource: getItInstance<
              WalletSystemUserBalanceAndTradeCallingLocalDatasource>(),
          walletSystemUserBalanceAndTradeCallingRemoteDatasource: getItInstance<
              WalletSystemUserBalanceAndTradeCallingRemoteDatasource>()));

  getItInstance
      .registerLazySingleton<WalletSystemUserBalanceAndTradeCallingBloc>(
    () => WalletSystemUserBalanceAndTradeCallingBloc(
        walletSystemUserBalanceAndTradeCallingRepository:
            getItInstance<WalletSystemUserBalanceAndTradeCallingRepository>(),
        appBloc: getItInstance<AppBloc>()),
  );
  // wallet_system_user_balance_and_trade_calling Bloc Ended......

  // trading_system Bloc ......
  getItInstance.registerLazySingleton<TradingSystemRemoteDatasource>(() =>
      TradingSystemRemoteDatasourceImpl(
          networkClient: getItInstance<SignalWalletNetworkClient>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<TradingSystemLocalDatasource>(() =>
      TradingSystemLocalDatasourceImpl(
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<TradingSystemRepository>(() =>
      TradingSystemRepositoryImpl(
          tradingSystemLocalDatasource:
              getItInstance<TradingSystemLocalDatasource>(),
          tradingSystemRemoteDatasource:
              getItInstance<TradingSystemRemoteDatasource>()));

  getItInstance.registerLazySingleton<TradingSystemBloc>(
    () => TradingSystemBloc(
        tradingSystemRepository: getItInstance<TradingSystemRepository>(),
        appBloc: getItInstance<AppBloc>()),
  );
  // trading_system Bloc Ended......

  // UserBloc ......
  getItInstance.registerLazySingleton<UserRemoteDatasource>(() =>
      UserRemoteDatasourceImpl(
          networkClient: getItInstance<SignalWalletNetworkClient>(),
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<UserLocalDatasource>(() =>
      UserLocalDatasourceImpl(
          appPreferenceService: getItInstance<AppPreferenceService>()));

  getItInstance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userLocalDatasource: getItInstance<UserLocalDatasource>(),
      userRemoteDatasource: getItInstance<UserRemoteDatasource>()));

  getItInstance.registerLazySingleton<UserBloc>(
    () => UserBloc(
        userRepository: getItInstance<UserRepository>(),
        appBloc: getItInstance<AppBloc>()),
  );
  // UserBloc Ended......
}
