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
    try {
      final result = await coinRemoteDatasource.getBTCDetail();

      return right(result);
    } catch (e) {
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
}
