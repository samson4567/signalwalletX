import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/tradeorder_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

bool hasInternet = true;

List<WalletAccountEntity> listOfWalletAccountEntityG = [];
List<CoinEntity> listOfCoinEntityG = [];

// String simpleswapBaseUrl = 'https://api.simpleswap.io';

String simpleswapBaseUrl = 'api.simpleswap.io';

double totalBalance = 0;

TraderOrderFollowedEntity? traderOrderFollowedEntity;

OrderEntity? currentOrderEntity;
