import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Market  Trading",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'inter',
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 30), // Added space below search bar
            Expanded(
                child:
                    _buildFancyContractMarket(context)), // Wrapped in Expanded
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 399,
      height: 39,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF313131)),
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search  by currency pair',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildFancyContractMarket(BuildContext context) {
    final List<Map<String, String>> coins = [
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Bitcoin',
        'price': '\$96,345.6',
        'percentage': '0.83%'
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Ethereum',
        'price': '\$6,345.2',
        'percentage': '1.12%'
      },
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/sol.png',
        'name': 'SOL',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/bch.png',
        'name': 'BCH',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/lit.png',
        'name': 'LIT',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$342.24',
        'percentage': '2.67%'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF313131), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contract Markets',
              style: TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'inter')),
          const SizedBox(height: 30),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Name',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                'Price',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
          const Divider(
              color: Color(0xFF313131),
              thickness: 1,
              height: 16), // Added divider below headers
          const SizedBox(height: 8),

          // List of Coins
          Expanded(
            child: ListView.separated(
              itemCount: coins.length,
              separatorBuilder: (context, index) => const Divider(
                  color: Color(0xFF313131), thickness: 1, height: 16),
              itemBuilder: (context, index) {
                final coin = coins[index];
                return Row(
                  children: [
                    const Icon(Icons.star_border,
                        color: Colors.yellow, size: 24),
                    const SizedBox(width: 12),
                    Image.asset(coin['icon']!, width: 32, height: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        coin['name']!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coin['price']!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          coin['percentage']!,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
