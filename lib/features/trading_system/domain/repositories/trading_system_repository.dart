import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';

abstract class TradingSystemRepository {
  // Future<Either<Failure, String>> newUserSignUp(
  //     {required NewUserRequestModel newUserRequest});
  // Future<Either<Failure, VerifySignUpEntity>> verifySignUp(
  //     {required String email, required String otp});
  // Future<Either<Failure, String>> resendOtp({required String email});
  // Future<Either<Failure, Map>> login(
  //     {required String email, required String password});
  // Future<Either<Failure, String>> logout({required String token});
  // Future<Either<Failure, String>> updatePassword({
  //   required String currentPassword,
  //   required String newPassword,
  //   required String newPasswordConfirmation,
  // });
  Future<Either<Failure, List<LiveMarketPriceEntity>>> fetchLiveMarketPrices();
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

  // getExchangeRate
}
