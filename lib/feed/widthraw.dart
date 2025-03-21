import 'package:flutter/material.dart';
import 'package:signalwavex/component/color.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String selectedFromCoin = 'BTC';
  String selectedToCoin = 'BTC';
  final TextEditingController fromAmountController = TextEditingController();
  final TextEditingController toAmountController = TextEditingController();

  String selectedCoin = 'BTC';
  String selectedChain = 'TRC20';
  String walletAddress = 'trtiueorwqrieotreppweoitrrioewpt';

  final List<Map<String, String>> coinList = [
    {'label': 'BTC', 'imagePath': 'assets/icons/bitcoin.png'},
    {'label': 'ETH', 'imagePath': 'assets/icons/sol.png'},
    {'label': 'TON', 'imagePath': 'assets/icons/ton.png'},
    {'label': 'XRP', 'imagePath': 'assets/icons/xrp.png'},
    {'label': 'BCH', 'imagePath': 'assets/icons/bch.png'},
    {'label': 'LTC', 'imagePath': 'assets/icons/lit.png'},
  ];

  final List<String> chainList = ['TRC20', 'ERC20', 'BEP20'];
  void _handleWithdraw() {
    double userBalance = 5.0; // Example balance (adjust as needed)
    double withdrawAmount = double.tryParse(toAmountController.text) ?? 0;
    String address = walletAddress.trim();

    // Address Validation (Example: Should be at least 25 characters long)
    if (address.length < 25) {
      _showDialog('invalid');
      return;
    }

    // Check if the user has enough balance
    if (withdrawAmount > userBalance) {
      _showDialog('insufficient');
    } else {
      _showDialog('success');
    }
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Text(
                      'Withdrawal',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cash out your assets',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'inter',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSelectionContainer(
                  label: 'Please select the currency to withdraw',
                  selectedItem: selectedCoin,
                  imagePath: coinList.firstWhere(
                      (coin) => coin['label'] == selectedCoin)['imagePath']!,
                  itemList: coinList.map((coin) => coin['label']!).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCoin = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildInfoContainer(), // New container added here
                const SizedBox(height: 16),
                _buildSelectionContainer(
                  label: 'Select Chain',
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
                  'Quantity',
                  selectedToCoin,
                  toAmountController,
                  (value) {
                    setState(() {
                      selectedToCoin = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                _buildHeadFeeContainer(
                  'Handling Fee',
                  selectedToCoin,
                  toAmountController,
                  (value) {
                    setState(() {
                      selectedToCoin = value!;
                    });
                  },
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
                    onTap: () {
                      _handleWithdraw();
                    },
                    child: const Center(
                      child: Text(
                        'Withdrawal',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionContainer({
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
                    selectedItem,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'qteuetietroritiyrtpep[wdfsfhfsdfhdfhhdg.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionContainer(
    String label,
    String selectedCoin,
    TextEditingController controller,
    ValueChanged<String?> onChanged,
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
    String selectedCoin,
    TextEditingController controller,
    ValueChanged<String?> onChanged,
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

  void _showDialog(String type) {
    String title;
    String message;
    String imagePath;

    if (type == 'success') {
      title = 'Transaction Successful';
      message = 'Your crypto has been successfully transferred.';
      imagePath = 'assets/icons/succeful.png';
    } else if (type == 'insufficient') {
      title = 'Insufficient Funds';
      message = 'You don\'t have enough BTC to complete this transaction.';
      imagePath = 'assets/icons/wrong.png';
    } else {
      title = 'Invalid Address';
      message = 'Please enter a valid withdrawal address.';
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
              Image.asset(imagePath, width: 80, height: 80),
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
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
}
