class EndpointConstant {
  static const String signUp = '/auth/register';
  static const String verifySignUp = '/auth/verify';
  static const String resendOtp = '/auth/resend-otp';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String updatePassword = '/auth/password/update';
  static const String fetchAllBalances = '/auth/me';
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
  static const String fetchOrderBook = '/market/orderbook';
  static const String placeABuyOrSellOrderRequest = '/trade/order';
  static const String deleteOrderRequest = '/trade/order';

  static const String fetchCompletedTrade = '/trade/history';
  static const String fetchCompletedTradeNew = '/trade/orders';

  static const String convert = '/wallet/convert';
  static const String getConversions = '/wallet/conversions';
  static const String getTradableCoin = "/market/tradable-coins";
  static const String interTransfer = "/wallet/transfer";
  static const String googleauth = "/auth/google";
  static const String forgetpassword = "/auth/forgot-password";
  static const String fetchMarketLiveCoinPrice = "/market/market-coins";
  static const String recentTransaction = "/trade/history";
  static const String btcData = "/market/btc/chart";

  static const String topCoin = "/market/top-coins";
  static const String marketCoin = "/market/market-coins";
  static const String verifyOTP = "/auth/verify-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String userLanguages = "/user/languages";
  static const String userProfile = "/auth/profile/update";

  static const String uploadGoogleToken = "/auth/google";
  static const String fetchActiveTrade = "/user/latest-trade";
  static const String tradeOrders = "/trade/orders";
  static const String fetchCoinPrice = "/market/klines?symbol=";
  static const String kycVerification = "/auth/verify-id";

  static const String registerPhoneNumberAsVerified = "/auth/phone/verify";
  static const String getRefferalCode = "/me/referral-code";
  static const String getRefferalList = "/me/referrals";

  // /me/referral-code

// /auth/phone/verify
}
