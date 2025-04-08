import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/admin_pending_withdrawal_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_response_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/repositories/wallet_system_user_balance_and_trade_calling_repository.dart';

import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';

class WalletSystemUserBalanceAndTradeCallingBloc extends Bloc<
    WalletSystemUserBalanceAndTradeCallingEvent,
    WalletSystemUserBalanceAndTradeCallingState> {
  final WalletSystemUserBalanceAndTradeCallingRepository
      walletSystemUserBalanceAndTradeCallingRepository;
  AppBloc appBloc;

  WalletSystemUserBalanceAndTradeCallingBloc(
      {required this.walletSystemUserBalanceAndTradeCallingRepository,
      required this.appBloc})
      : super(const WalletSystemUserBalanceAndTradeCallingInitial()) {
    on<FetchAllAccountBalanceEvent>(_onFetchAllAccountBalanceEvent);
    on<DepositAddressRetrivalEvent>(_onDepositAddressRetrivalEvent);
    on<TradeWithdrawalRequestEvent>(_onTradeWithdrawalRequestEvent);
    on<AdminSetWitdrawalEvent>(_onAdminSetWitdrawalEvent);
    on<GetAdminPendingWithdrawalRequestEvent>(
        _onGetAdminPendingWithdrawalRequestEvent);

    on<InternalTransferEvent>(_onInternalTransferEvent);

    on<ListTradesAUserIsFollowingEvent>(_onListTradesAUserIsFollowingEvent);
    on<CreateTradeCallBySuperAdminEvent>(_onCreateTradeCallBySuperAdminEvent);
    on<FetchAllTradesEvent>(_onFetchAllTradesEvent);
    on<SetWithdrawalPasswordEvent>(_onSetWithdrawalPasswordEvent);
    on<GetpnlEvent>(_onGetpnlEvent);
    on<WithdrawalEvent>(_onWithdrawalEvent);
    on<BtcDataChartEvent>(_onBtcDataChartEvent);
    on<FetchUserTransactionsEvent>(_onFetchUserTransactionsEvent);

    //FetchUserTransactions
  }

  Future<void> _onFetchAllAccountBalanceEvent(FetchAllAccountBalanceEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const FetchAllAccountBalanceLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .fetchAllBalances();
    result.fold(
      (error) =>
          emit(FetchAllAccountBalanceErrorState(errorMessage: error.message)),
      (listOfWalletsBalances) {
        appBloc.add(StoreUserBalancesEvent(
            listOfWalletAccountEntity: listOfWalletsBalances));
        listOfWalletAccountEntityG = listOfWalletsBalances;
        emit(FetchAllAccountBalanceSuccessState(
            listOfWalletsBalances: listOfWalletsBalances));
      },
    );
  }

  Future<void> _onDepositAddressRetrivalEvent(DepositAddressRetrivalEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const DepositAddressRetrivalLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .retriveDepositAddress(chain: event.chain, currency: event.currency);
    result.fold(
      (error) =>
          emit(DepositAddressRetrivalErrorState(errorMessage: error.message)),
      (depositAddressEntity) => emit(DepositAddressRetrivalSuccessState(
          depositAddressEntity: depositAddressEntity)),
    );
  }

  Future<void> _onTradeWithdrawalRequestEvent(TradeWithdrawalRequestEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const TradeWithdrawalRequestLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .requestTradeWithdrawal(
            tradeWithdrawalRequestRequestEntity:
                event.tradeWithdrawalRequestRequestEntity);
    result.fold(
      (error) =>
          emit(TradeWithdrawalRequestErrorState(errorMessage: error.message)),
      (tradeWithdrawalRequestResponseModel) => emit(
          TradeWithdrawalRequestSuccessState(
              tradeWithdrawalRequestResponseModel:
                  (tradeWithdrawalRequestResponseModel
                      as TradeWithdrawalRequestResponseModel))),
    );
  }

  Future<void> _onAdminSetWitdrawalEvent(AdminSetWitdrawalEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const AdminSetWitdrawalLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .adminSetWitdrawal(withdrawalFee: event.withdrawalFee);
    result.fold(
      (error) => emit(AdminSetWitdrawalErrorState(errorMessage: error.message)),
      (message) => emit(AdminSetWitdrawalSuccessState(message: message)),
    );
  }

  Future<void> _onGetAdminPendingWithdrawalRequestEvent(
      GetAdminPendingWithdrawalRequestEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const GetAdminPendingWithdrawalRequestLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .getAdminPendingWithdrawalRequest();
    result.fold(
      (error) => emit(GetAdminPendingWithdrawalRequestErrorState(
          errorMessage: error.message)),
      (listOfAdminPendingWithdrawalRequest) => emit(
          GetAdminPendingWithdrawalRequestSuccessState(
              listOfAdminPendingWithdrawalRequest:
                  listOfAdminPendingWithdrawalRequest
                      as List<AdminPendingWithdrawalRequestModel>)),
    );
  }

  Future<void> _onInternalTransferEvent(InternalTransferEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const InternalTransferLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .doInternalTransfer(
            internalTransferEntity: event.internalTransferEntity);
    result.fold(
      (error) => emit(InternalTransferErrorState(errorMessage: error.message)),
      (message) => emit(
        InternalTransferSuccessState(message: message),
      ),
    );
  }

  Future<void> _onListTradesAUserIsFollowingEvent(
      ListTradesAUserIsFollowingEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const ListTradesAUserIsFollowingLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .listTradesAUserIsFollowing();
    result.fold(
      (error) => emit(
          ListTradesAUserIsFollowingErrorState(errorMessage: error.message)),
      (listOfTradeEntities) => emit(
        ListTradesAUserIsFollowingSuccessState(
            listOfTradeEntities: listOfTradeEntities),
      ),
    );
  }

  Future<void> _onCreateTradeCallBySuperAdminEvent(
      CreateTradeCallBySuperAdminEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const CreateTradeCallBySuperAdminLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .createTradeCallBySuperAdmin(tradeEntity: event.tradeEntity);
    result.fold(
      (error) => emit(
          CreateTradeCallBySuperAdminErrorState(errorMessage: error.message)),
      (tradeEntity) => emit(
        CreateTradeCallBySuperAdminSuccessState(tradeEntity: tradeEntity),
      ),
    );
  }

  // _onFetchAllTradesEvent
  Future<void> _onFetchAllTradesEvent(FetchAllTradesEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const FetchAllTradesLoadingState());
    final result =
        await walletSystemUserBalanceAndTradeCallingRepository.fetchAllTrades();
    result.fold(
      (error) => emit(FetchAllTradesErrorState(errorMessage: error.message)),
      (listOfTradeEntities) => emit(
        FetchAllTradesSuccessState(listOfTradeEntities: listOfTradeEntities),
      ),
    );
  }

  Future<void> _onSetWithdrawalPasswordEvent(SetWithdrawalPasswordEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const SetWithdrawalPasswordLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .setWithdrawalPassword(
            withdrawPassword: event.withdrawPassword,
            withdrawPasswordConfirmation: event.withdrawPasswordConfirmation);
    result.fold(
      (error) =>
          emit(SetWithdrawalPasswordErrorState(errorMessage: error.message)),
      (listOfTradeEntities) => emit(
        SetWithdrawalPasswordSuccessState(message: listOfTradeEntities),
      ),
    );
  }

  Future<void> _onGetpnlEvent(GetpnlEvent event,
      Emitter<WalletSystemUserBalanceAndTradeCallingState> emit) async {
    emit(const GetpnlLoadingState());
    final result =
        await walletSystemUserBalanceAndTradeCallingRepository.getpnl();
    result.fold(
      (error) => emit(GetpnlErrorState(errorMessage: error.message)),
      (pnl) {
        appBloc.add(StorePNLEvent(pnl: pnl));
        emit(GetpnlSuccessState(pnl: pnl));
      },
    );
  }

  Future<void> _onWithdrawalEvent(
    WithdrawalEvent event,
    Emitter<WalletSystemUserBalanceAndTradeCallingState> emit,
  ) async {
    emit(const WithdrawalLoadingState());
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .processWithdrawal(withdrawEntity: event.withdrawEntity);
    result.fold(
      (error) => emit(WithdrawalErrorState(errorMessage: error.message)),
      (message) => emit(
        WithdrawalSuccessState(
            message: message, withdrawEntity: event.withdrawEntity),
      ),
    );
  }

  Future<void> _onBtcDataChartEvent(
    BtcDataChartEvent event,
    Emitter<WalletSystemUserBalanceAndTradeCallingState> emit,
  ) async {
    emit(const BtcDataChartLoadingState());

    // Assuming you have a repository method to fetch BTC chart data
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .fetchBtcDataChart(symbol: event.symbol);

    result.fold(
      (error) => emit(BtcDataChartErrorState(errorMessage: error.message)),
      (btcDataChart) =>
          emit(BtcDataChartSuccessState(btcDataChart: btcDataChart)),
    );
  }

  Future<void> _onFetchUserTransactionsEvent(
    FetchUserTransactionsEvent event,
    Emitter<WalletSystemUserBalanceAndTradeCallingState> emit,
  ) async {
    emit(const FetchUserTransactionsLoadingState());

    // Assuming you have a repository method to fetch BTC chart data
    final result = await walletSystemUserBalanceAndTradeCallingRepository
        .fetchUserTransactions();

    result.fold(
      (error) =>
          emit(FetchUserTransactionsErrorState(errorMessage: error.message)),
      (listOfOrderEntity) => emit(FetchUserTransactionsSuccessState(
          listOfOrderEntity: listOfOrderEntity)),
    );
  }
}
