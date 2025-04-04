class EndpointConstant {
  static const String signUp = '/auth/register';
  static const String verifySignUp = '/auth/verify';
  static const String resendOtp = '/auth/resend-otp';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String updatePassword = '/auth/password/update';
  static const String fetchAllBalances = '/wallet/balance';
  static const String retriveDepositAddress = '/wallet/deposit';
  static const String tradeWithdrawRequest = '/wallet/withdraw-request';
  static const String adminSetCharges = '/admin/set-withdrawal-fee';
  static const String getAdminPendingWithdrawalRequest =
      '/admin/withdraw-requests';
  static const String doInternalTransfer = '/wallet/transfer';
  static const String listTradesAUserIsFollowing = '/user/trade-following';
  static const String followTradeCall = '/user/trade/join';
  static const String createTradeCallBySuperAdmin = '/user/trade-following';
  static const String fetchAllTrades = '/admin/trade-calls';
  static const String setWithdrawalPassword = '/wallet/set-withdraw-password';
  static const String getpnl = '/user/pnl';
  static const String fetchLiveMarketPrices = '/market/ticker';
  static const String fetchOrderBook = '/market/orderbook';
  static const String placeABuyOrSellOrderRequest = '/trade/order';
  static const String fetchCompletedTrade = '/trade/history';
  static const String convert = '/wallet/convert';
  static const String getConversions = '/wallet/conversions';
  static const String getTradableCoin = "/market/tradable-coins";
  static const String interTransfer = "/wallet/transfer";
  static const String googleauth = "/auth/google";
  static const String forgetpassword = "/auth/forgot-password";
}
