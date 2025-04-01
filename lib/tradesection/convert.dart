import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/component/custom_image_viewer.dart';
import 'package:signalwavex/component/snackbars.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/data/models/conversion_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_state.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  CoinEntity? selectedFromCoin;
  CoinEntity? selectedToCoin;
  final TextEditingController fromAmountController = TextEditingController();
  final TextEditingController toAmountController = TextEditingController();

  final List<Map<String, String>> coinList = [
    {'label': 'BTC', 'imagePath': 'assets/icons/bitcoin.png'},
    {'label': 'ETH', 'imagePath': 'assets/icons/sol.png'},
    {'label': 'TON', 'imagePath': 'assets/icons/ton.png'},
    {'label': 'XRP', 'imagePath': 'assets/icons/xrp.png'},
    {'label': 'BCH', 'imagePath': 'assets/icons/bch.png'},
    {'label': 'LTC', 'imagePath': 'assets/icons/lit.png'},
  ];

  @override
  void initState() {
    context.read<TradingSystemBloc>().add(const GetCoinListEvent());
    super.initState();
  }

  List<CoinModel>? listOFCoin;
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
          children: [
            Text(
              'Convert',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Zeroes trading fees',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TradingSystemBloc, TradingSystemState>(
            listener: (BuildContext context, TradingSystemState state) {
          if (state is GetCoinListSuccessState) {
            listOFCoin = (state.listOfCoinEntity as List<CoinModel>);
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
                content: Text("${state.errorMessage}"),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is ConversionSuccessState) {
            _showDialog('success');
          }
          if (state is ConversionErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.errorMessage}"),
                backgroundColor: Colors.green,
              ),
            );
          }
        }, builder: (context, state) {
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
              : Column(
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
                          _buildConversionContainer(
                            'From',
                            selectedFromCoin,
                            fromAmountController,
                            (value) {
                              setState(() {
                                selectedFromCoin = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Image.asset(
                              'assets/icons/button.png', // Replace with your actual image path
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildConversionContainer(
                            'To',
                            selectedToCoin,
                            toAmountController,
                            (value) {
                              setState(() {
                                selectedToCoin = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Exchange rate: 1 USDT = 0.0000123 BTC',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          _buildConvertButton(),
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  Widget _buildConversionContainer(
    String label,
    CoinEntity? selectedCoin,
    TextEditingController controller,
    ValueChanged<CoinEntity?> onChanged,
  ) {
    bool isTo = label.toLowerCase() == "to";
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
              if (!isTo)
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
                  ),
                ),
              DropdownButton<CoinEntity>(
                value: selectedCoin,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                underline: const SizedBox(),
                onChanged: onChanged,
                items: listOFCoin?.map((coin) {
                  return DropdownMenuItem<CoinEntity>(
                    value: coin,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: "assets/icons/bitcoin.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(coin.name!),
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

  Widget _buildConvertButton() {
    return GestureDetector(
      onTap: () {
        if (selectedFromCoin != null) {
          double enteredAmount =
              double.tryParse(fromAmountController.text) ?? 0;
          double availableBalance = double.parse(
              getCoinWaletDetails(context, selectedFromCoin!)?.actualQuantity ??
                  "0");
          //  0.000019; // Simulating balance for demo

          if (enteredAmount > availableBalance) {
            _showDialog('insufficient',
                why: "availableBalance-${availableBalance}");
          } else {
            ConversionModel conversionEntity = ConversionModel(
              fromCurrency: selectedFromCoin?.symbol,
              symbol: null,
              toCurrency: selectedToCoin?.symbol,
              fromAmount: fromAmountController.text,
              toAmount: null,
              rate: null,
              createdAt: null,
            );
            context
                .read<TradingSystemBloc>()
                .add(ConversionEvent(conversionEntity));
          }
        } else {
          // ('select coin')
          ScaffoldMessenger.of(context)
              .showSnackBar(generalSnackBar("Select A Coin"));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Convert',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showDialog(String type, {String? why}) {
    String title =
        type == 'success' ? 'Transaction Successful' : 'Insufficient Funds';
    String message = type == 'success'
        ? 'Your crypto has been successfully transferred.\n${why ?? ''}'
        : 'You don\'t have enough BTC to complete this transaction.\n${why ?? ''}';
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
                message,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      child: const Text('Continue',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
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
}
