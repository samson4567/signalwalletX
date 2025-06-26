import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/router/api_route.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String selectedFromOption = 'Trade';
  String selectedToOption = 'Exchange';
  final List<String> actionList = ['Trade', 'Convert', 'Transfer'];
  final List<String> toOptionsList = ['TRC20', 'ERC20'];
  final List<String> optionsList = ["Trade", "Exchange"];

  String? selectedCurrency;
  double availableBalance = 0.0;

  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    availableBalance = totalBalance;
    super.initState();
  }

  List<WalletAccountEntity> listOfTradeWalletAccountEntity = [];
  List<WalletAccountEntity> listOfExchangeWalletAccountEntity = [];
  List<WalletAccountEntity> listOfWalletAccountEntityOnUse = [];

  @override
  Widget build(BuildContext context) {
    print("sajhdhsbdjhasbdahsdb-selectedFromOption_${selectedFromOption}");
    listOfWalletAccountEntityOnUse = listOfWalletAccountEntityG
        .where(
          (element) => element.accountType == selectedFromOption.toLowerCase(),
        )
        .toList();
    print("sajhdhsbdjhasbdahsdb-selectedFromOption_lsigthd_${[
      listOfWalletAccountEntityG.length,
      listOfWalletAccountEntityOnUse.length,
    ]}");

    availableBalance = listOfWalletAccountEntityOnUse
        .where(
      (element) => element.currency == selectedCurrency,
    )
        .fold(0, (sum, wallet) {
      final balance = double.tryParse(wallet.actualQuantity ?? '0') ?? 0;
      return sum + balance;
    });
    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is InternalTransferSuccessState) {
          context.read<WalletSystemUserBalanceAndTradeCallingBloc>().add(
                const FetchUserTransactionsEvent(),
              );
          _showDialog('success', message: state.message);
        } else if (state is InternalTransferErrorState) {
          _showDialog('Error',
              headerLiteral: "Error",
              message: (state.errorMessage.length < 25)
                  ? state.errorMessage
                  : "Something Went Wrong");
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Column(
              children: [
                Text('Transfer', style: TextStyle(color: Colors.white)),
                Text(
                  'Move Your Assets',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: state is InternalTransferLoadingState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildActionDropdownContainer(
                          'From',
                          selectedFromOption,
                          optionsList,
                          // .where(
                          //   (element) => selectedToOption != element,
                          // )
                          // .toList(),
                          (value) {
                            setState(() {
                              selectedFromOption = value!;
                              selectedToOption = optionsList
                                  .where(
                                    (element) => selectedToOption != element,
                                  )
                                  .toList()[0];
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildActionDropdownContainer(
                          'To',
                          selectedToOption,
                          optionsList,
                          (value) {
                            // .where(
                            //     (element) => selectedAction != element,
                            //   )
                            if (selectedFromOption == value) {
                              return;
                            }
                            setState(() => selectedToOption = value!);
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildCurrencyContainer(),
                        const SizedBox(height: 16),
                        _buildAmountContainer(),
                        const SizedBox(height: 8),
                        Text(
                          'Available ${_formatCurrency(availableBalance)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _handleExchange,
                          child: _buildFancyExchangeButton(),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildActionDropdownContainer(
    String label,
    String selectedValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(selectedValue,
                  style: const TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
          DropdownButton<String>(
            value: selectedValue,
            dropdownColor: Colors.black,
            style: const TextStyle(color: Colors.white),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            underline: const SizedBox(),
            onChanged: onChanged,
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Amount',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              TextButton(
                onPressed: () {
                  // final blocState = context
                  //     .read<WalletSystemUserBalanceAndTradeCallingBloc>()
                  //     .state;
                  // if (blocState is FetchAllAccountBalanceSuccessState) {
                  //   availableBalance = double.tryParse(
                  //           blocState.listOfWalletsBalances.first.currency ??
                  //               '${0}') ??
                  //       0.0;

                  //   // Format availableBalance with dollar sign

                  // }
                  try {
                    amountController.text = "${availableBalance}";
                  } catch (e) {}
                },
                child: const Text(
                  'Max',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyContainer() {
    List<String> currencies = ["USDT", "USDC"];
    // listOfWalletAccountEntityG
    //     .map(
    //       (e) => e.currency ?? '',
    //     )
    //     .toSet()
    //     .toList();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Currency', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  isExpanded: true,
                  dropdownColor: Colors.black,
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    print(
                        "sajhdhsbdjhasbdahsdb-onChanged-listOfWalletAccountEntityOnUse.length_${listOfWalletAccountEntityOnUse.length}");
                    // availableBalance = listOfWalletAccountEntityOnUse
                    //     .where(
                    //   (element) => element.currency == value,
                    // )
                    //     .fold(0, (sum, wallet) {
                    //   final balance =
                    //       double.tryParse(wallet.actualQuantity ?? '0') ?? 0;
                    //   return sum + balance;
                    // });
                    selectedCurrency = value;
                    setState(() {});
                  },
                  items: currencies.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFancyExchangeButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Exchange',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleExchange() {
    print("sabahsjdadjhb-amountController.text_is_${amountController.text}");

    String amountinString = amountController.text.replaceAll("\$", "");
    print(
        "sabahsjdadjhb-amountController.text_afterwards_is_${amountinString}");

    final double? amount = double.tryParse(amountinString);
    print("sabahsjdadjhb-amount_is_${amount}");
    if (amount == null || amount <= 0) {
      _showDialog('invalid');
    } else if (amount > availableBalance) {
      _showDialog('insufficient');
    }
    //  else if (amount < 1) {
    //   _showDialog('Error',
    //       headerLiteral: "insufficient", message: "Amount less than 1");
    // }
    else {
      final transferEntity = InternalTransferEntity(
        amount: amount.toString(),
        fromWallet: "",
        toWallet: "",
        toAccount: selectedToOption.toLowerCase(),
        fromAccount: selectedFromOption.toLowerCase(),
        currency: selectedCurrency,
      );
      context.read<WalletSystemUserBalanceAndTradeCallingBloc>().add(
            InternalTransferEvent(transferEntity),
          );
    }
  }

  void _showDialog(String type, {String? headerLiteral, String? message}) {
    String title = type == 'success'
        ? 'Transaction Successful'
        : type == 'invalid'
            ? 'Invalid Amount'
            : type == "insufficient"
                ? 'Insufficient Funds'
                : headerLiteral ?? "";

    String finalMessage = message ??
        (type == 'success'
            ? 'Your crypto has been successfully transferred.'
            : 'You don\'t have enough BTC to complete this transaction.');

    String imagePath = type == 'success'
        ? 'assets/icons/succeful.png'
        : 'assets/icons/wrong.png';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, width: 80, height: 80),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                finalMessage,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: type == 'success'
                    ? [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]
                    : [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              context.push(MyAppRouteConstant.deposit);
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add Funds',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
