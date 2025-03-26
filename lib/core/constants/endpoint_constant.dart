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

// trading system endpoint

  static const String fetchLiveMarketPrices = '/market/ticker';
}
