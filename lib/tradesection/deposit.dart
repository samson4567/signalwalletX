import 'package:flutter/material.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
      body: SingleChildScrollView(
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
                  _buildAddressContainer(),
                ],
              ),
            ),
            // Address + QR Code Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Address',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/icons/qr.png', // Replace with actual QR code asset
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Save QR Code',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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

                  SizedBox(width: 8), // Space between the image and text
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
                            style: TextStyle(fontSize: 14, color: Colors.grey),
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

  Widget _buildAddressContainer() {
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
                  walletAddress,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.grey),
                onPressed: () {
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
