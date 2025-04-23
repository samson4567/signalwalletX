import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_state.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/deposit_address_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  String? selectedCoin;
  CoinModel? selectedCoinModel;

  String? selectedChain;
  String walletAddress = 'trtiueorwqrieotreppweoitrrioewpt';

  DepositAddressModel? selectedDepositAddressModel;
  final List<Map<String, String>> coinList = [
    {'label': 'BTC', 'imagePath': 'assets/icons/bitcoin.png'},
    {'label': 'ETH', 'imagePath': 'assets/icons/sol.png'},
    {'label': 'TON', 'imagePath': 'assets/icons/ton.png'},
    {'label': 'XRP', 'imagePath': 'assets/icons/xrp.png'},
    {'label': 'BCH', 'imagePath': 'assets/icons/bch.png'},
    {'label': 'LTC', 'imagePath': 'assets/icons/lit.png'},
  ];

  final List<String> chainList = ['TRC20', 'ERC20', 'BEP20'];

  @override
  void initState() {
    context.read<TradingSystemBloc>().add(const GetCoinListEvent());
    super.initState();
  }

  List<CoinModel>? listOfCoins;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Deposit',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Top Up Your Wallet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TradingSystemBloc, TradingSystemState>(
          listener: (BuildContext context, TradingSystemState state) {
        if (state is GetCoinListSuccessState) {
          listOfCoins = (state.listOfCoinEntity as List<CoinModel>);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("coin successfully"),
              backgroundColor: Colors.green,
            ),
          );
// _showDialog('success');
        }

        if (state is GetCoinListErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.green,
            ),
          );
        }
      }, builder: (context, state) {
        // listOFCoins
        return (state is GetCoinListLoadingState)
            ? const Center(
                child: SizedBox(
                  height: 50,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSelectionContainer(
                            label: 'Select the coins you want to deposit',
                            selectedItem: selectedCoin,
                            imagePath: "assets/icons/bitcoin.png",
                            itemList: listOfCoins ?? [],
                            onChanged: (value) {
                              selectedChain = null;
                              setState(() {});

                              selectedCoin = value!;
                              listOfCoins?.forEach(
                                (element) {
                                  if (selectedCoin == element.symbol) {
                                    selectedCoinModel = element;
                                  }
                                },
                              );
                              if ((selectedCoin?.isNotEmpty ?? false) &&
                                  (selectedChain?.isNotEmpty ?? false)) {
                                context
                                    .read<
                                        WalletSystemUserBalanceAndTradeCallingBloc>()
                                    .add(DepositAddressRetrivalEvent(
                                        currency: selectedCoin!,
                                        chain: selectedChain!));
                              }
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildSelectionContainer2(
                            label: 'Select Chain',
                            selectedItem: selectedChain,
                            coinModel: selectedCoinModel,
                            itemList: chainList,
                            onChanged: (value) {
                              setState(() {
                                selectedChain = value!;
                                if ((selectedCoin?.isNotEmpty ?? false) &&
                                    (selectedChain?.isNotEmpty ?? false)) {
                                  context
                                      .read<
                                          WalletSystemUserBalanceAndTradeCallingBloc>()
                                      .add(
                                        DepositAddressRetrivalEvent(
                                          currency: selectedCoin!,
                                          chain: selectedChain!,
                                        ),
                                      );
                                }
                              });
                            },
                            imagePath: '',
                          ),
                          const SizedBox(height: 16),
                          BlocConsumer<
                                  WalletSystemUserBalanceAndTradeCallingBloc,
                                  WalletSystemUserBalanceAndTradeCallingState>(
                              listener: (BuildContext context,
                                  WalletSystemUserBalanceAndTradeCallingState
                                      state) {
                            if (state is DepositAddressRetrivalSuccessState) {
                              selectedDepositAddressModel = state
                                  .depositAddressEntity as DepositAddressModel;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "deposit detail fetched successfully",
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
// _showDialog('success');
                            }

                            if (state is DepositAddressRetrivalErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }, builder: (context, state) {
                            return (selectedDepositAddressModel != null)
                                ? ((state is DepositAddressRetrivalLoadingState)
                                    ? const Center(
                                        child: SizedBox(
                                          height: 50,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                        ),
                                      )
                                    : _buildAddressContainer(
                                        selectedDepositAddressModel!))
                                : FancyContainerTwo(
                                    child:
                                        const Text("Select A chain and a coin"),
                                  );
                          }),
                        ],
                      ),
                    ),
                    // Address + QR Code Section

                    if ((selectedDepositAddressModel != null))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Image.memory(
                              getImageDataFromString(
                                  selectedDepositAddressModel!.qRCode!),
                              // 'assets/icons/qr.png', // Replace with actual QR code asset
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Save QR Code',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    // Disclaimer Section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon or image asset to the left of the disclaimer

                          SizedBox(
                              width: 8), // Space between the image and text
                          // Text content
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Disclaimer !!! ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Please double-check the address and the selected chain before making a deposit. Depositing funds to the wrong address or chain may result in the loss of your assets.',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildSelectionContainer({
    required String label,
    required String? selectedItem,
    required String imagePath,
    required List<CoinEntity> itemList,
    required ValueChanged<String?> onChanged,
  }) {
    // getCoinImageFromAsset
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (selectedCoinModel != null)
                    (getCoinImageFromAsset(selectedCoinModel!) == null)
                        ? SizedBox(
                            width: 24,
                            height: 24,
                          )
                        : Image.asset(
                            getCoinImageFromAsset(selectedCoinModel!),
                            width: 24,
                            height: 24,
                          ),
                  const SizedBox(width: 8),
                  Text(
                    selectedItem ?? "select a coin",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              DropdownButton<String>(
                value: selectedItem,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                underline: const SizedBox(),
                onChanged: onChanged,
                items: itemList.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.symbol,
                    child: Row(
                      children: [
                        (getCoinImageFromAsset(item) == null)
                            ? SizedBox(
                                width: 24,
                                height: 24,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Image.asset(
                                  getCoinImageFromAsset(item),
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                        Text(item.name ?? ""),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionContainer2({
    required String label,
    required String? selectedItem,
    required String imagePath,
    required List<String> itemList,
    required ValueChanged<String?> onChanged,
    required CoinModel? coinModel,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: (selectedItem == null && coinModel == null)
          ? const Text("Select a coin")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (imagePath.isNotEmpty)
                          Image.asset(
                            imagePath,
                            width: 24,
                            height: 24,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          selectedItem ?? "Select a chain",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: selectedItem,
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      underline: const SizedBox(),
                      onChanged: onChanged,
                      items: coinModel!.chains?.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildAddressContainer(DepositAddressModel depositAddressModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  depositAddressModel.depositAddress!,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.grey),
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: depositAddressModel.depositAddress!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.black,
                      content: Text(
                        'Address copied to clipboard',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
