import 'package:flutter/material.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  String selectedFromCoin = 'BTC';
  String selectedToCoin = 'BTC';
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
        child: Column(
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
        ),
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
              DropdownButton<String>(
                value: selectedCoin,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                underline: const SizedBox(),
                onChanged: onChanged,
                items: coinList.map((coin) {
                  return DropdownMenuItem<String>(
                    value: coin['label'],
                    child: Row(
                      children: [
                        Image.asset(
                          coin['imagePath']!,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(coin['label']!),
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
        double enteredAmount = double.tryParse(fromAmountController.text) ?? 0;
        double availableBalance = 0.000019; // Simulating balance for demo

        if (enteredAmount > availableBalance) {
          _showDialog('insufficient');
        } else {
          _showDialog('success');
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

  void _showDialog(String type) {
    String title =
        type == 'success' ? 'Transaction Successful' : 'Insufficient Funds';
    String message = type == 'success'
        ? 'Your crypto has been successfully transferred.'
        : 'You don\'t have enough BTC to complete this transaction.';
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
