import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

abstract class CoinRepository {
  Future<Either<Failure, CoinEntity>> getBTCDetails();
  Future<Either<Failure, List<CoinEntity>>> getTopCoins();
  Future<Either<Failure, List<CoinEntity>>> getMarketCoins();
  Future<Either<Failure, String?>> fetchCoinPrice(
      {required String tradingPairSymbol});
}
