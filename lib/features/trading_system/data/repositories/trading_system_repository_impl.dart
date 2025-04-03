import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_local_datasource.dart';
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_remote_datasource.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';
import 'package:signalwavex/features/trading_system/domain/repositories/trading_system_repository.dart';

class TradingSystemRepositoryImpl implements TradingSystemRepository {
  TradingSystemRepositoryImpl({
    required this.tradingSystemRemoteDatasource,
    required this.tradingSystemLocalDatasource,
  });

  final TradingSystemRemoteDatasource tradingSystemRemoteDatasource;
  final TradingSystemLocalDatasource tradingSystemLocalDatasource;

  @override
  Future<Either<Failure, List<LiveMarketPriceEntity>>>
      fetchLiveMarketPrices() async {
    try {
      final result =
          await tradingSystemRemoteDatasource.fetchLiveMarketPrices();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, OrderBookEntity>> fetchOrderBook(
      {required String symbol}) async {
    try {
      final result =
          await tradingSystemRemoteDatasource.fetchOrderBook(symbol: symbol);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> placeABuyOrSellOrderRequest(
      {required PlaceABuyOrSellOrderRequestEntity
          placeABuyOrSellOrderRequestEntity}) async {
    try {
      final result =
          await tradingSystemRemoteDatasource.placeABuyOrSellOrderRequest(
              placeABuyOrSellOrderRequestEntity:
                  placeABuyOrSellOrderRequestEntity);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ConversionEntity>> convert(
      {required ConversionEntity conversionEntity}) async {
    try {
      final result = await tradingSystemRemoteDatasource.convert(
          conversionEntity: conversionEntity);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ConversionEntity>>> getConversions() async {
    try {
      final result = await tradingSystemRemoteDatasource.getConversions();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CoinEntity>>> getCoins() async {
    try {
      final result = await tradingSystemRemoteDatasource.getCoins();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> getExchangeRate(
      {required String from, required String to}) async {
    print("debug_print_getExchangeRate-start");
    try {
      final result =
          await tradingSystemRemoteDatasource.getExchangeRate(from, to);
      print("debug_print_getExchangeRate-result=${result}");

      return right(result);
    } catch (e) {
      print("debug_print_getExchangeRate-error=${e}");
      return left(mapExceptionToFailure(e));
    }
  }
}
