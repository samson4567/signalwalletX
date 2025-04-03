import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/custom_image_viewer.dart';
import 'package:signalwavex/component/date_time_display.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/flow_amination_screen.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_state.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/router/api_route.dart';
import 'package:signalwavex/testScreen/line_chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  void initState() {
    getAndSetInitialData(context);
    selectedCoin = context.read<AppBloc>().state.listOfCoinEntity?.firstOrNull;
    if (selectedCoin != null) {
      context
          .read<TradingSystemBloc>()
          .add(FetchOrderBookEvent("${selectedCoin!.symbol}USDT"));
    }

    // FetchLiveMarketPricesEvent
    liveDataFecthRepeater = Timer.periodic(
      20.seconds,
      (timer) {
        context.read<TradingSystemBloc>().add(FetchLiveMarketPricesEvent());
      },
    );
    super.initState();
  }

  Timer? liveDataFecthRepeater;
  CoinEntity? selectedCoin;
  Map askBids = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;
    print(
        "sdabkjbdabsdbakjdbasbkds-11111${context.read<AppBloc>().state.listOfCoinEntity}");
    print(
        "sdabkjbdabsdbakjdbasbkds-22222${context.read<AppBloc>().state.listOfWalletAccounts}");
    print("sdabkjbdabsdbakjdbasbkds-33333${context.read<AppBloc>().state.pnl}");
    print("sdabkjbdabsdbakjdbasbkds-444${context.read<AppBloc>().state.user}");

    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey, // Add scaffold key
      drawer: drawerComponent(context), // Drawer
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(screenWidth, _scaffoldKey),
            Expanded(
              // Ensure scrolling works properly
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: padding, vertical: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth * 0.04),
                    _buildFancyContainer(context),
                    SizedBox(height: screenWidth * 0.04),
                    _buildFancyChartContainer(context),
                    SizedBox(height: screenWidth * 0.04),
                    _buildFancyRecentTransaction(context),
                    SizedBox(height: screenWidth * 0.04),
                    _buildFancyRecentTopcoin(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      double screenWidth, GlobalKey<ScaffoldState> scaffoldKey) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final user = context.read<AppBloc>().state.user;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<TradingSystemBloc>().add(
                          FetchOrderBookEvent("${selectedCoin!.symbol}USDT"));
                    },
                    child: Image.asset(
                      'assets/icons/flower.png',
                      fit: BoxFit.contain,
                      height: screenWidth * 0.1,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, ${user?.email}',
                        style: TextStyles.smallText.copyWith(
                          fontSize: screenWidth * 0.022,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      LiveDateTimeWidget(
                        textStyle: TextStyles.bodyText.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: ColorConstants.primarydeepColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      // Text(
                      //   'Feb 12 2022 • 05:22', // Format this dynamically if needed
                      // style: TextStyles.bodyText.copyWith(
                      //   fontSize: screenWidth * 0.035,
                      //   color: ColorConstants.primarydeepColor,
                      //   fontWeight: FontWeight.w600,
                      // ),
                      // ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
        // Return an empty container if the state is not authenticated
      },
    );
  }

  Widget _buildFancyContainer(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth = screenWidth * 0.9;
    containerWidth = containerWidth > 400 ? 400 : containerWidth;

    double containerHeight = containerWidth * 0.805;

    return FancyContainer(
      color: const Color(0xFF101112),
      width: containerWidth,
      height: containerHeight,
      borderRadius: BorderRadius.circular(containerWidth * 0.05), // 5% of width
      border: Border.all(
        color: ColorConstants.lineborder,
        width: containerWidth * 0.005,
      ),
      padding: EdgeInsets.all(containerWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalAssetsSection(containerWidth, context),
          SizedBox(height: containerWidth * 0.04),
          _buildPnLSection(containerWidth),
          SizedBox(height: containerWidth * 0.1),
          _buildIconRow(containerWidth),
        ],
      ),
    );
  }

  Widget _buildFancyChartContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101112),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey, // Replace with your actual border color
          width: 2,
        ),
      ),
      width: 400,
      height: 435,
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<TradingSystemBloc, TradingSystemState>(
          listener: (BuildContext context, TradingSystemState state) {
        if (state is FetchOrderBookSuccessState) {
          askBids = {
            "asks": state.orderBookEntity.asks,
            "bids": state.orderBookEntity.bids,
          };
        } else if (state is FetchOrderBookErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is GetCoinListSuccessState) {
          selectedCoin = state.listOfCoinEntity.firstOrNull;
          context
              .read<TradingSystemBloc>()
              .add(FetchOrderBookEvent("${selectedCoin!.symbol}USDT"));
        }
      }, builder: (context, state) {
        return (state is GetCoinListLoadingState)
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
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedCoin != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "${selectedCoin!.name!} USDT (${selectedCoin!.symbol!} - USDT)",
                                action: () async {
                                  selectedCoin = await showDialog<CoinEntity>(
                                        context: context,
                                        builder: (context) {
                                          List<CoinEntity> listOfCoinModel =
                                              listOfCoinEntityG;
                                          // context
                                          //         .read<AppBloc>()
                                          //         .state
                                          //         .listOfCoinEntity ??
                                          //     [];
                                          print(
                                              "listOfCoinModellistOfCoinModellistOfCoinModellistOfCoinModel${listOfCoinModel}");
                                          // listOfCoinModel
                                          return Dialog(
                                            child: FancyContainerTwo(
                                              nulledAlign: true,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: listOfCoinModel
                                                      .map(
                                                        (e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: FancyText(
                                                            "${e.name}(${e.symbol})",
                                                            action: () {
                                                              context.pop(e);
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ) ??
                                      selectedCoin;
                                  context.read<TradingSystemBloc>().add(
                                      FetchOrderBookEvent(
                                          "${selectedCoin!.symbol}USDT"));
                                  setState(() {});
                                },
                                // style: TextStyle(fontSize: 14, color: Colors.white),
                                size: 14, textColor: Colors.white,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "+ 231.43 (1.02%)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors
                                      .green, // Replace with your color constant
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 37.5,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.1),
                            border: Border.all(
                                color: Colors
                                    .grey), // Replace with your color constant
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "24 Hours",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  const Text(
                    "\$97,3120",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Builder(builder: (context) {
                    return Expanded(
                      child: (state is FetchOrderBookLoadingState)
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
                          : (selectedCoin != null && askBids.isNotEmpty)
                              ? LineChart(
                                  chartDetails: {
                                    "symbol":
                                        "${selectedCoin!.symbol!.toUpperCase()}USDT",
                                    "period": period,
                                    "askAndBids": askBids
                                  },
                                )
                              : FancyContainerTwo(
                                  child: const Text("Select A coin"),
                                ), // Call the function to create chart data
                    );
                  }),
                ],
              );
      }),
    );
  }

  String period = "1day";
  Widget _buildFancyRecentTransaction(BuildContext context) {
    final List<Map<String, String>> transactions = [
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'amount': '+4132.01DOGE',
        'action': 'Buy',
        'time': '9:20 AM'
      },
      {
        'icon': 'assets/icons/ton.png',
        'name': 'TON',
        'amount': '+4132.01TON',
        'action': 'Buy',
        'time': '10:45 AM'
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'ETH',
        'amount': '+4132.01ETH',
        'action': 'Buy',
        'time': '11:30 AM'
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'XRP',
        'amount': '+4132.01XRP',
        'action': 'Buy',
        'time': '12:15 PM'
      },
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'amount': '+4132.01DOGE',
        'action': 'Buy',
        'time': '1:05 PM'
      },
    ];

    return FancyContainer(
      color: const Color(0xFF101112),
      width: 400,
      height: 435,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ColorConstants.lineborder,
        width: 2,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transaction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        transaction['icon']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['name']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Buy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction['amount']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorConstants.numyelcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transaction['time']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<LiveMarketPriceEntity> listOfLiveMarketPriceEntity = [];

  Widget _buildFancyRecentTopcoin(BuildContext context) {
    final List<Map<String, String>> coins = [
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Bitcoin',
        'price': '\$96,345.6',
        'percentage': '0.83%',
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Ethereum',
        'price': '\$6,345.2',
        'percentage': '1.12%',
      },
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/sol.png',
        'name': 'SOL',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/bch.png',
        'name': 'BCH',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/lit.png',
        'name': 'LIT',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
    ];

    return FancyContainer(
      color: const Color(0xFF101112),
      width: 400,
      height: 435,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ColorConstants.lineborder,
        width: 2,
      ),
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<TradingSystemBloc, TradingSystemState>(
          listener: (BuildContext context, TradingSystemState state) {
        if (state is FetchLiveMarketPricesSuccessState) {
          listOfLiveMarketPriceEntity = state.listOfLiveMarketPriceEntity;
          listOfLiveMarketPriceEntity.removeWhere(
            (element) {
              return !(element.symbol?.toLowerCase().endsWith("usdt") ?? true);
            },
          );
          listOfLiveMarketPriceEntity.sort(
            (a, b) {
              return double.parse(
                      extractPercentageValue(b.twentyFourHourChange!))
                  .compareTo(double.parse(
                      extractPercentageValue(a.twentyFourHourChange!)));
            },
          );
        } else if (state is FetchLiveMarketPricesErrorState) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.errorMessage),
          //     backgroundColor: Colors.green,
          //   ),
          // );
        }
      }, builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top performing coins',
                style: TextStyles.normaltext.copyWith()),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: listOfLiveMarketPriceEntity.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xFF313131),
                  thickness: 1,
                  height: 16,
                ),
                itemBuilder: (context, index) {
                  final coin = listOfLiveMarketPriceEntity[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      CustomImageView(
                        // coin['icon']!,
                        imagePath: "assets/icons/bitcoin.png",
                        // coin.symbol!,

                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // coin['name']!,
                              coin.symbol!,

                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // coin['price']!,
                            coin.price!,
                            style: TextStyle(
                              fontSize: 14,
                              color: !(coin.didIncrease ?? false)
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // coin['percentage']!,
                            coin.twentyFourHourChange!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
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
        );
      }),
    );
  }

  String extractPercentageValue(String rawValue) {
    print("debug_print_extractPercentageValue-rawValue=${rawValue}");
    String result = rawValue;
    if (result.startsWith(RegExp("^[^a-zA-Z0-9]"))) {
      result = result.substring(1);
    }
    if (result.endsWith("%")) {
      result = result.substring(0, result.length - 1);
    }
    print("debug_print_extractPercentageValue-result=${result}");

    return result;
  }

  Widget _buildTotalAssetsSection(double screenWidth, BuildContext context) {
    final walletBloc =
        BlocProvider.of<WalletSystemUserBalanceAndTradeCallingBloc>(context);

    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is FetchAllAccountBalanceErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchAllAccountBalanceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        double totalBalance = 0;
        if (state is FetchAllAccountBalanceSuccessState) {
          totalBalance = state.listOfWalletsBalances.fold(0, (sum, wallet) {
            final balance = double.tryParse(wallet.actualQuantity ?? '0') ?? 0;
            return sum + balance;
          });
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Assets',
                      style: TextStyles.title.copyWith(
                        fontSize: screenWidth * 0.045, // 4.5% of screen width
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () {
                        // Refresh balances when the eye icon is pressed
                        walletBloc.add(const FetchAllAccountBalanceEvent());
                      },
                    ),
                  ],
                ),
                Text(
                  // Display real balance or placeholder
                  state is FetchAllAccountBalanceSuccessState
                      ? '\$${totalBalance.toStringAsFixed(2)}'
                      : 'Loading...',
                  style: TextStyles.smallText.copyWith(
                    fontSize: screenWidth * 0.08,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPnLSection(double screenWidth) {
    return Row(
      children: [
        Text(
          'Today\'s PnL:',
          style: TextStyles.subtitle.copyWith(
            fontSize: screenWidth * 0.045, // Font size 4.5% of screen width
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: screenWidth * 0.01), // 1% spacing
        BlocConsumer<AppBloc, AppState>(
            listener: (BuildContext context, AppState state) {
          if (state is StorePNLSuccessState) {}
        }, builder: (context, state) {
          return Text(
            '+\$${state.pnl?.substring(0, 4) ?? 0}',
            style: TextStyles.smallText.copyWith(
              fontSize: screenWidth * 0.045, // Font size 4.5% of screen width
              color: ColorConstants.numyelcolor,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildIconRow(double screenWidth) {
    final List<Map<String, dynamic>> iconsData = [
      {
        'imagePath': 'assets/icons/double.png',
        'label': 'Trade',
        'action': () {
          context.push(MyAppRouteConstant.perpetual);
        }
      },
      {
        'imagePath': 'assets/icons/Refresh.png',
        'label': 'Convert',
        'action': () {
          context.push(MyAppRouteConstant.convert);
        }
      },
      {
        'imagePath': 'assets/icons/arrowdown.png',
        'label': 'Deposit',
        'action': () {
          context.push(MyAppRouteConstant.deposit);
        }
      },
      {
        'imagePath': 'assets/icons/dang.png',
        'label': 'Transfer',
        'action': () {
          context.push(MyAppRouteConstant.transfer);
        }
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: iconsData.asMap().entries.map((entry) {
        final index = entry.key;
        final icon = entry.value;
        return _buildIconItem(
          imagePath: icon['imagePath']!,
          label: icon['label']!,
          screenWidth: screenWidth,
          isSelected: _selectedIndex == index,
          onTap: () {
            icon['action']?.call();
            setState(() {
              _selectedIndex = index;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildIconItem({
    required String imagePath,
    required String label,
    required double screenWidth,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: FancyContainer(
        width: 75, // Fixed width
        height: 68, // Fixed height
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: isSelected
              ? const Color.fromARGB(255, 28, 23, 192)
              : ColorConstants.primarydeepColor,
        ),
        color: isSelected ? ColorConstants.blueSelectionColor : Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: screenWidth * 0.1, // 10% of screen width
                  height: screenWidth * 0.1,
                ),
                SizedBox(height: screenWidth * 0.01), // 1% spacing
                Text(
                  label,
                  style: TextStyles.caption.copyWith(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
