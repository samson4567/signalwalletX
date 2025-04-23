import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
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
  String selectedAction = 'Trade';
  String selectedToOption = 'TRC20';
  final List<String> actionList = ['Trade', 'Convert', 'Transfer'];
  final List<String> toOptionsList = ['TRC20', 'ERC20'];

  double availableBalance = 0.0;

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    availableBalance = totalBalance;
    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is InternalTransferSuccessState) {
          _showDialog('success', message: state.message);
        } else if (state is InternalTransferErrorState) {
          _showDialog('insufficient', message: state.errorMessage);
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
                          'Trade',
                          selectedAction,
                          actionList,
                          (value) {
                            setState(() => selectedAction = value!);
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildActionDropdownContainer(
                          'To',
                          'Exchange',
                          selectedToOption,
                          toOptionsList,
                          (value) {
                            setState(() => selectedToOption = value!);
                          },
                        ),
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
    String valueLabel,
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
              Text(valueLabel,
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
                  final blocState = context
                      .read<WalletSystemUserBalanceAndTradeCallingBloc>()
                      .state;
                  if (blocState is FetchAllAccountBalanceSuccessState) {
                    availableBalance = double.tryParse(
                            blocState.listOfWalletsBalances.first.currency ??
                                '${0}') ??
                        0.0;

                    // Format availableBalance with dollar sign
                    amountController.text = _formatCurrency(availableBalance);
                  }
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
    final double? amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      _showDialog('invalid');
    } else if (amount > availableBalance) {
      _showDialog('insufficient');
    } else {
      final transferEntity = InternalTransferEntity(
        amount: amount.toString(),
        fromWallet: selectedAction,
        toWallet: selectedToOption,
        toAccount: '',
        fromAccount: '',
        currency: '',
      );
      context
          .read<WalletSystemUserBalanceAndTradeCallingBloc>()
          .add(InternalTransferEvent(transferEntity));
    }
  }

  void _showDialog(String type, {String? message}) {
    String title = type == 'success'
        ? 'Transaction Successful'
        : type == 'invalid'
            ? 'Invalid Amount'
            : 'Insufficient Funds';

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
