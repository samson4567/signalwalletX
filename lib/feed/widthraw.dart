import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/withdraw_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/settings/referral_section.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String selectedCoin = 'USDC';
  String selectedChain = 'TRC20';
  String walletAddress = '';
  final TextEditingController fromAmountController = TextEditingController();
  final TextEditingController toAmountController = TextEditingController();
  final TextEditingController handlingFeeController = TextEditingController();

  final TextEditingController walletAddressController = TextEditingController();

  final List<CoinEntity> coinList = [
    const CoinEntity(
        symbol: 'USDC', name: 'USD Coin', imagePath: 'assets/icons/usdc.png'),
    const CoinEntity(
        symbol: 'USDT', name: 'Tether', imagePath: 'assets/icons/tether.png'),
    // {'label': 'BTC', 'imagePath': 'assets/icons/bitcoin.png'},
    // {'label': 'ETH', 'imagePath': 'assets/icons/sol.png'},
    // {'label': 'TON', 'imagePath': 'assets/icons/ton.png'},
    // {'label': 'XRP', 'imagePath': 'assets/icons/xrp.png'},
    // {'label': 'BCH', 'imagePath': 'assets/icons/bch.png'},
    // {'label': 'LTC', 'imagePath': 'assets/icons/lit.png'},
  ];

  final List<String> chainList = ['TRC20', 'ERC20', 'BEP20'];

  void _handleWithdraw() {
    double withdrawAmount = double.tryParse(toAmountController.text) ?? 0;
    String address = walletAddress.trim();

    if (address.isEmpty || address.length < 25) {
      _showDialog('invalid');
      return;
    }

    if (withdrawAmount <= 0) {
      _showDialog('insufficient');
      return;
    }

    final withdrawEntity = WithdrawEntity(
      coin: selectedCoin,
      amount: withdrawAmount,
      address: address,
      chain: selectedChain,
      currency: selectedCoin,
      withdrawAddress: address,
    );

    context
        .read<WalletSystemUserBalanceAndTradeCallingBloc>()
        .add(WithdrawalEvent(withdrawEntity: withdrawEntity));
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
            WalletSystemUserBalanceAndTradeCallingState>(
          listener: (context, state) {
            if (state is WithdrawalErrorState) {
              _showDialog('insufficient');
            } else if (state is WithdrawalSuccessState) {
              context.read<WalletSystemUserBalanceAndTradeCallingBloc>().add(
                    const FetchUserTransactionsEvent(),
                  );
              _showDialog('success');
            }
          },
          builder: (context, state) {
            if (state is WithdrawalLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Withdrawal'.toCurrentLanguage(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cash out your assets'.toCurrentLanguage(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'inter',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSelectionContainer(
                      label: 'Please select the currency to withdraw'
                          .toCurrentLanguage(),
                      selectedItem: coinList
                          .firstWhere((coin) => coin.symbol == selectedCoin),
                      imagePath: coinList
                          .firstWhere((coin) => coin.symbol == selectedCoin)
                          .imagePath!,
                      itemList: coinList,
                      // .map((coin) => coin.symbol!).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCoin = value!.symbol!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildInfoContainer(),
                    const SizedBox(height: 16),
                    _buildChainListSelectionContainer(
                      label: 'Select Chain'.toCurrentLanguage(),
                      selectedItem: selectedChain,
                      itemList: chainList,
                      onChanged: (value) {
                        setState(() {
                          selectedChain = value!;
                        });
                      },
                      imagePath: '',
                    ),
                    const SizedBox(height: 16),
                    _buildConversionContainer(
                      'Quantity'.toCurrentLanguage(),
                      toAmountController,
                    ),
                    const SizedBox(height: 16),
                    _buildHeadFeeContainer(
                      'Handling Fee (5%)'.toCurrentLanguage(),
                      handlingFeeController,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.numyelcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 41,
                      width: 370,
                      child: InkWell(
                        onTap: _handleWithdraw,
                        child: Center(
                          child: Text(
                            'Withdrawal'.toCurrentLanguage(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectionContainer({
    required String label,
    required CoinEntity selectedItem,
    required String imagePath,
    required List<CoinEntity> itemList,
    required ValueChanged<CoinEntity?> onChanged,
  }) {
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
                  if (imagePath.isNotEmpty)
                    Image.asset(
                      imagePath,
                      width: 24,
                      height: 24,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    selectedItem.symbol!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              DropdownButton<CoinEntity>(
                value: selectedItem,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                underline: const SizedBox(),
                onChanged: onChanged,
                items: itemList.map((item) {
                  return DropdownMenuItem<CoinEntity>(
                    value: item,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(item.imagePath!),
                        ),
                        5.horizontalSpace,
                        Text(item.symbol!),
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

  Widget _buildChainListSelectionContainer({
    required String label,
    required String selectedItem,
    required String imagePath,
    required List<String> itemList,
    required ValueChanged<String?> onChanged,
  }) {
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
                  if (imagePath.isNotEmpty)
                    Image.asset(
                      imagePath,
                      width: 24,
                      height: 24,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    selectedItem!,
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

  Widget _buildInfoContainer() {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'To',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: walletAddressController, // Use the controller here
            style: const TextStyle(fontSize: 16, color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter Address',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                walletAddress = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConversionContainer(
    String label,
    TextEditingController controller,
  ) {
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
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountContainer(
    String label,
    TextEditingController controller,
  ) {
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
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeadFeeContainer(
    String label,
    TextEditingController controller,
  ) {
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
              FancyText(
                () {
                  double? d = double.tryParse(toAmountController.text);
                  String dString = "$d";
                  if (d != null) {
                    dString = (d * .05).toStringAsFixed(2);
                  }
                  return (d == null) ? "--" : dString;
                }.call(),
                textColor: Colors.white,
              )
              // Expanded(
              //   child: TextField(
              //     controller: controller,
              //     style: const TextStyle(color: Colors.white),
              //     keyboardType: TextInputType.number,
              //     decoration: const InputDecoration(
              //       hintText: '0',
              //       hintStyle: TextStyle(color: Colors.grey),
              //       border: InputBorder.none,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(String type) {
    String title;
    String message;
    String imagePath;

    if (type == 'success') {
      title = 'Transaction Successful'.toCurrentLanguage();
      message =
          'Your crypto has been successfully transferred.'.toCurrentLanguage();
      imagePath = 'assets/icons/succeful.png'.toCurrentLanguage();
    } else if (type == 'insufficient') {
      title = 'Insufficient Funds'.toCurrentLanguage();
      message = 'You don\'t have enough BTC to complete this transaction.'
          .toCurrentLanguage();
      imagePath = 'assets/icons/wrong.png';
    } else {
      title = 'Invalid Address'.toCurrentLanguage();
      message = 'Please enter a valid withdrawal address.'.toCurrentLanguage();
      imagePath = 'assets/icons/wrong.png';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close'.toCurrentLanguage(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
