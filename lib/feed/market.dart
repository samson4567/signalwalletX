import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/custom_image_viewer.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_bloc.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_event.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_state.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<CoinModel>? listOfCoinModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    context.read<CoinBloc>().add(const GetMarketCoinsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<CoinBloc, CoinState>(listener: (context, state) {
        // GetBTCDetail reactions
        if (state is GetMarketCoinsSuccessState) {
          listOfCoinModel = state.listOfCoinModel;
          setState(() {});
        } else if (state is GetBTCDetailErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.green,
            ),
          );
        }
        // GetBTCDetail reactions ended.....

        // GetTopCoin reactions
        if (state is GetTopCoinSuccessState) {
          listOfCoinModel = state.listOfCoinModel;
        } else if (state is GetTopCoinErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.green,
            ),
          );
        }
        // GetTopCoin reactions ended.....
      }, builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop(MyAppRouteConstant.home);
                          },
                          child:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    Text(
                      "Market Trading".toCurrentLanguage(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildSearchBar(),
                const SizedBox(height: 30),
                Expanded(
                  child: _buildFancyContractMarket(context, state),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 399,
      height: 48,
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search  by currency pair'.toCurrentLanguage(),
          hintStyle: const TextStyle(color: Color(0xFF8F8F8F), fontSize: 10),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildFancyContractMarket(BuildContext context, CoinState state) {
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
          Text('Contract Markets'.toCurrentLanguage(),
              style: const TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'inter')),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Name'.toCurrentLanguage(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                'Price'.toCurrentLanguage(),
                style: const TextStyle(
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
          (state is GetMarketCoinsLoadingState || listOfCoinModel == null)
              ? const Center(
                  child: SizedBox(
                    // bjksbdjk,d
                    height: 50,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemCount: listOfCoinModel!.length,
                    separatorBuilder: (context, index) => const Divider(
                        color: Color(0xFF313131), thickness: 1, height: 16),
                    itemBuilder: (context, index) {
                      final coin = listOfCoinModel![index];
                      return Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            color: Color(0xFF313131),
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          CustomImageView(
                            imagePath: getCoinImageFromAsset(coin),
                            // coin['icon']!,
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              coin.name!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                coin.price!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                coin.percentIncrease!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3BCC70),
                                ),
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
