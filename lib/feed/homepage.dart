import 'dart:async';
import 'dart:convert';

import 'package:signalwavex/languages.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/custom_image_viewer.dart';
import 'package:signalwavex/component/date_time_display.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/component/empty_widget.dart';
// import 'package:signalwavex/component/empty_widget';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_bloc.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_event.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_state.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_state.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/order_model.dart';

import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/router/api_route.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/chart_test/line_chart_long_pulled.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  // BtcDataChartEntity? chartLoading;
  @override
  void initState() {
    getAndSetInitialData(context);
    context.read<WebSocketBloc>().add(
        const WebSocketConnectEvent("wss://stream.bybit.com/v5/public/linear"));

    getData();

    super.initState();
  }

  getData() {
    context
        .read<WalletSystemUserBalanceAndTradeCallingBloc>()
        .add(const FetchUserTransactionsEvent());

    context.read<CoinBloc>().add(const GetBTCDetailEvent());
    context.read<CoinBloc>().add(const GetTopCoinEvent());
    context.read<CoinBloc>().add(const GetMarketCoinsEvent());
  }

  Timer? liveDataFecthRepeater;

  Map askBids = {};
  CoinModel? btcCoinModel;
  List<CoinModel>? listOfCoinModel;
  List<OrderModel>? listOfOrderEntity;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      drawer: drawerComponent(context),
      body: BlocConsumer<CoinBloc, CoinState>(listener: (context, state) {
        // GetBTCDetail reactions
        if (state is GetBTCDetailSuccessState) {
          btcCoinModel = state.coinModel;
          context.read<WebSocketBloc>().add(SubscribeToCryptoEvent(
                interval: period,
                symbol: "BTC",
              ));

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
                      _buildFancyRecentTopcoin(context, state),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
                      // context.read<TradingSystemBloc>().add(
                      //     FetchOrderBookEvent("${selectedCoin!.symbol}USDT"));
                      getData();

                      // languageDetails
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
                        '${toCurrentLanguageFunction("Good Morning")}, ${user?.email}',
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

  Map<String, dynamic> cad = {};
  Widget _buildFancyChartContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101112),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      width: 400,
      height: 435,
      padding: const EdgeInsets.all(16),
      child: (btcCoinModel == null)
          ? const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : BlocConsumer<CoinBloc, CoinState>(
              listener: (context, state) {},
              builder: (context, state) {
                return (state is GetBTCDetailLoadingState)
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
                    : BlocConsumer<WebSocketBloc, WebSocketState>(
                        listener: (context, state) {
                        if (state is WebSocketDataState) {
                          final decodedData = jsonDecode(state.data);
                          if ((decodedData["topic"] as String?)
                                  ?.startsWith("kline.") ??
                              false) {
                            cad =
                                calculatePriceChange(decodedData["data"][0]) ??
                                    {};
                          }
                          try {} catch (e) {}
                        }
                        if (state is WebSocketConnectedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(toCurrentLanguageFunction("connected")),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                        // state;
                      }, builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FancyText(
                                        // "${btcCoinModel!.name!} USDT (${btcCoinModel!.symbol!} - USDT)",
                                        "Bitcoin USDT (BTC - USDT)",

                                        // style: TextStyle(fontSize: 14, color: Colors.white),
                                        size: 14, textColor: Colors.white,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${(cad?["percentageChange"] ?? "")} (${cad?["valueChange"] ?? ""}) ",
                                        // btcCoinModel?.percentIncrease
                                        //         .toString() ??
                                        //     '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ((double.tryParse(
                                                          cad["percentageChange"] ??
                                                              "") as double?)
                                                      ?.isNegative ??
                                                  false)
                                              ? Colors.red
                                              : Colors
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
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.1),
                                      border: Border.all(
                                          color: Colors
                                              .grey), // Replace with your color constant
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildPeriodSelect(),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${cad?["currentPrice"]}",
                              style: const TextStyle(
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
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            ),
                                          ),
                                        )
                                      : LineChartLongPulled(
                                          chartDetails: chartDetails ??
                                              {
                                                "symbol": "BTCUSDT",
                                                "period": period,
                                                "askAndBids": askBids
                                              },
                                        ));
                            }),
                          ],
                        );
                      });
              }),
    );
  }

  Map? chartDetails = {};
  String period = "1";

  Widget buildPeriodSelect() {
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      dropdownStyleData: const DropdownStyleData(width: 200),
      items: [
        // 1
        DropdownMenuItem(
          value: "1",
          onTap: () {
            period = "1";
            chartDetails = {
              "symbol": "BTCUSDT",
              "period": period,
              "askAndBids": askBids
            };

            setState(() {});
          },
          child: FancyText(
            toCurrentLanguageFunction("1 min"),
            weight: FontWeight.w400,
            size: 12,
          ),
        ),
        DropdownMenuItem(
          value: "5",
          onTap: () {
            period = "5";
            chartDetails = {
              "symbol": "BTCUSDT",
              "period": period,
              "askAndBids": askBids
            };

            setState(() {});
          },
          child: FancyText(
            toCurrentLanguageFunction("5 min"),
            weight: FontWeight.w400,
            size: 12,
          ),
        ),
        DropdownMenuItem(
          value: "D",
          onTap: () {
            period = "D";
            chartDetails = {
              "symbol": "BTCUSDT",
              "period": period,
              "askAndBids": askBids
            };

            setState(() {});
          },
          child: FancyText(
            toCurrentLanguageFunction("24 hours"),
            weight: FontWeight.w400,
            size: 12,
          ),
        ),
        DropdownMenuItem(
          value: "M",
          onTap: () {
            period = "M";
            chartDetails = {
              "symbol": "BTCUSDT",
              "period": period,
              "askAndBids": askBids
            };

            setState(() {});
          },
          child: FancyText(
            toCurrentLanguageFunction("1 Month"),
            weight: FontWeight.w400,
            size: 12,
          ),
        ),
      ],
      value: period,
      onChanged: (value) {},
    ));
  }

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

    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
            WalletSystemUserBalanceAndTradeCallingState>(
        listener: (context, state) {
      // FetchUserTransactions reactions

      if (state is FetchUserTransactionsSuccessState) {
        listOfOrderEntity = state.listOfOrderEntity
            .map(
              (e) => OrderModel.fromEntity(e),
            )
            .toList();
        setState(() {});
      } else if (state is FetchUserTransactionsErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.green,
          ),
        );
      }
      // FetchUserTransactions reactions ended.....
    }, builder: (context, state) {
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
            Text(
              toCurrentLanguageFunction('Recent Transaction'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              toCurrentLanguageFunction('Today'),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            (state is FetchUserTransactionsLoadingState ||
                    listOfOrderEntity == null)
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
                    child: (listOfOrderEntity!.isEmpty)
                        ? buildEmptyWidget(
                            toCurrentLanguageFunction("No Transactions yet"),
                          )
                        : ListView.builder(
                            itemCount: listOfOrderEntity!.length,
                            itemBuilder: (context, index) {
                              final transaction = listOfOrderEntity![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      // transaction.
                                      'assets/icons/doge.png',
                                      // ['icon']!,
                                      width: 48,
                                      height: 48,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.symbol!,
                                            // ['name']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            transaction.side?.toLowerCase() ??
                                                "-",
                                            // 'Buy',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transaction.quantity ?? "-",
                                          // transaction['amount']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.numyelcolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          getTrasactionDateFormat(
                                              transaction.orderTime),
                                          // transaction.orderTime ?? "-",
                                          // ['time']!,
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
    });
  }

  Widget _buildFancyRecentTopcoin(BuildContext context, CoinState state) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top performing coins', style: TextStyles.normaltext),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                toCurrentLanguageFunction('Name'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                toCurrentLanguageFunction('Price'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          (state is GetTopCoinLoadingState || listOfCoinModel == null)
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemCount: listOfCoinModel!.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xFF313131),
                      thickness: 1,
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      final coin = listOfCoinModel![index];
                      CoinModel;
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
                            imagePath: getCoinImageFromAsset(coin),
                            width: 32,
                            height: 32,
                            errorWidget: Image.asset(
                              'assets/icons/doge.png',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coin.name!,
                                  // coin['name']!,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                coin.price ?? "-",
                                // ['price']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                coin.percentIncrease ?? "-",
                                // coin['percentage']!,
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
      ),
    );
  }

  String extractPercentageValue(String rawValue) {
    String result = rawValue;
    if (result.startsWith(RegExp("^[^a-zA-Z0-9]"))) {
      result = result.substring(1);
    }
    if (result.endsWith("%")) {
      result = result.substring(0, result.length - 1);
    }

    return result;
  }

  Widget _buildTotalAssetsSection(double screenWidth, BuildContext context) {
    final walletBloc =
        BlocProvider.of<WalletSystemUserBalanceAndTradeCallingBloc>(context);

    // Track the visibility state of the balance
    bool isBalanceVisible = true;

    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is FetchAllAccountBalanceErrorState) {
          // Handle the error state
        }
      },
      builder: (context, state) {
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
                      toCurrentLanguageFunction('Total Assets'),
                      style: TextStyles.title.copyWith(
                        fontSize: screenWidth * 0.045,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    IconButton(
                      icon: Icon(
                        isBalanceVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () {
                        isBalanceVisible = !isBalanceVisible;

                        walletBloc.add(const FetchAllAccountBalanceEvent());
                      },
                    ),
                  ],
                ),
                Text(
                  // Show balance only if visible, otherwise show a placeholder (like '*****')
                  isBalanceVisible
                      ? '\$${totalBalance.toStringAsFixed(2)}' // Shows 0.00 if balance is 0
                      : '*****', // Placeholder text for hidden balance
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
          toCurrentLanguageFunction('Today\'s PnL:'),
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
        'label': toCurrentLanguageFunction('Trade'),
        'action': () {
          context.push(MyAppRouteConstant.features);
        }
      },
      {
        'imagePath': 'assets/icons/Refresh.png',
        'label': toCurrentLanguageFunction('Convert'),
        'action': () {
          context.push(MyAppRouteConstant.convert);
        }
      },
      {
        'imagePath': 'assets/icons/arrowdown.png',
        'label': toCurrentLanguageFunction('Deposit'),
        'action': () {
          context.push(MyAppRouteConstant.deposit);
        }
      },
      {
        'imagePath': 'assets/icons/dang.png',
        'label': toCurrentLanguageFunction('Transfer'),
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
