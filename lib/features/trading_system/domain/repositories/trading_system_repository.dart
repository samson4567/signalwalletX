import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';

import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/tradeorder_entity.dart';

abstract class TradingSystemRepository {
  Future<Either<Failure, OrderBookEntity>> fetchOrderBook(
      {required String symbol});

  Future<Either<Failure, String>> placeABuyOrSellOrderRequest(
      {required PlaceABuyOrSellOrderRequestEntity
          placeABuyOrSellOrderRequestEntity});
  Future<Either<Failure, ConversionEntity>> convert(
      {required ConversionEntity conversionEntity});
  Future<Either<Failure, List<ConversionEntity>>> getConversions();
  Future<Either<Failure, List<CoinEntity>>> getCoins();
  Future<Either<Failure, String>> getExchangeRate(
      {required String from, required String to});
  Future<TraderOrderFollowedEntity> fetchTraderOrderFollowed(String tid);
}
