import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/coin/data/datasources/coin_local_datasource.dart';
import 'package:signalwavex/features/coin/data/datasources/coin_remote_datasource.dart';
import 'package:signalwavex/features/coin/domain/repositories/coin_repository.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

class CoinRepositoryImpl implements CoinRepository {
  CoinRepositoryImpl({
    required this.coinRemoteDatasource,
    required this.coinLocalDatasource,
  });

  final CoinRemoteDatasource coinRemoteDatasource;
  final CoinLocalDatasource coinLocalDatasource;

  @override
  Future<Either<Failure, CoinEntity>> getBTCDetails() async {
    print("debug_print_CoinRepositoryImpl-getBTCDetails-started");
    try {
      final result = await coinRemoteDatasource.getBTCDetail();
      print("debug_print_CoinRepositoryImpl-getBTCDetails-result_is_$result ");
      return right(result);
    } catch (e) {
      print("debug_print_CoinRepositoryImpl-getBTCDetails-error_is_$e ");
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CoinEntity>>> getTopCoins() async {
    try {
      final result = await coinRemoteDatasource.getTopCoins();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CoinEntity>>> getMarketCoins() async {
    try {
      final result = await coinRemoteDatasource.getMarketCoins();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> fetchCoinPrice(
      {required String tradingPairSymbol}) async {
    print("debug_print-CoinRepositoryImpl-fetchCoinPrice-started");
    try {
      final result = await coinRemoteDatasource.fetchCoinPrice(
          tradPairSymbol: tradingPairSymbol);
      print(
          "debug_print-CoinRepositoryImpl-fetchCoinPrice-result_is_${result}");

      return right(result);
    } catch (e) {
      print("debug_print-CoinRepositoryImpl-fetchCoinPrice-e_is_${e}");
      return left(mapExceptionToFailure(e));
    }
  }
}
