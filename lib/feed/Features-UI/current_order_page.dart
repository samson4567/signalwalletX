import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/component/empty_widget.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/order_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/feed/Features-UI/components/confirm_order_dialog.dart';
import 'package:signalwavex/feed/Features-UI/components/order_followed_dialog.dart';
import 'package:signalwavex/component/back_button.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/component/radio_button.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/chart_test/candle_stick_chart.dart';

import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';
import 'package:uuid/uuid.dart';

class FeaturesCurrentOrder extends StatefulWidget {
  const FeaturesCurrentOrder({super.key});

  @override
  State<FeaturesCurrentOrder> createState() => _FeaturesCurrentOrderState();
}

class _FeaturesCurrentOrderState extends State<FeaturesCurrentOrder> {
  EdgeInsets externalPadding = const EdgeInsets.symmetric(horizontal: 20);
  String? selectedText;
  bool isDepth = false;

  List<Map> currentOrderMap = [
    {"k": "Product", "v": "BTC/USDT (5mins)", "c": getFigmaColor("F0B90B")},
    {"k": "Status", "v": "Pending", "c": Colors.white},
    {"k": "Direction", "v": "call", "c": getFigmaColor("C6E229")},
    {"k": "Time Period", "v": "08:29:17", "c": Colors.white},
    {"k": "Open Price", "v": "--", "c": Colors.white},
    {"k": "Amount", "v": "30", "c": Colors.white},
    {"k": "Open Position Time", "v": "2025/02/9 08:29:17", "c": Colors.white},
    {"k": "Turnover", "v": "30", "c": Colors.white},
    {"k": "Rate of Return", "v": "87.20%", "c": Colors.white},
    {"k": "Action", "v": "Cancel", "c": getFigmaColor("CA3F64")},
  ];

  List convertTradeEntityToMap(TradeModel tradeModel) {
    return [
      {
        "k": "Product",
        "v": "${tradeModel.tradingPair}",
        "c": getFigmaColor("F0B90B")
      },
      {"k": "Status", "v": "${tradeModel.status}", "c": Colors.white},
      {
        "k": "Direction",
        "v": "${tradeModel.orderDirection}",
        "c": getFigmaColor("C6E229")
      },
      {
        "k": "Time Period",
        "v": "${tradeModel.purchaseDuration}",
        "c": Colors.white
      },
      {"k": "Open Price", "v": "--", "c": Colors.white},
      {"k": "Amount", "v": "--", "--": Colors.white},
      {
        "k": "Open Position Time",
        "v": "${tradeModel.orderTime}",
        "c": Colors.white
      },
      {"k": "Turnover", "v": "30", "c": Colors.white},
      {"k": "Rate of Return", "v": "87.20%", "c": Colors.white},
      {"k": "Action", "v": "Cancel", "c": getFigmaColor("CA3F64")},
    ];
  }

  List<TradeModel> currentOrderEntities = [];
  List<OrderModel> historOrderEntities = [];

  List convertOrderEntityToMap(OrderModel orderModel) {
    // orderModel.;
    return [
      {
        "k": "Product",
        "v": "${orderModel.tradingPair}",
        "c": getFigmaColor("F0B90B")
      },
      {"k": "Status", "v": "${orderModel.status}", "c": Colors.white},
      {
        "k": "Direction",
        "v": "${orderModel.side}",
        "c": getFigmaColor("C6E229")
      },
      {
        "k": "Time Period",
        "v": "${orderModel.purchaseDuration}",
        "c": Colors.white
      },
      {"k": "Open Price", "v": "--", "c": Colors.white},
      {"k": "Amount", "v": "--", "--": Colors.white},
      {
        "k": "Open Position Time",
        "v": "${orderModel.orderTime}",
        "c": Colors.white
      },
      {"k": "Turnover", "v": "30", "c": Colors.white},
      {"k": "Rate of Return", "v": "87.20%", "c": Colors.white},
      {"k": "Action", "v": "Cancel", "c": getFigmaColor("CA3F64")},
    ];
  }

  List<Map> historOrderMap = [
    {"k": "Product", "v": "BTC/USDT (5mins)", "c": getFigmaColor("F0B90B")},
    {"k": "Status", "v": "Pending", "c": Colors.white},
    {"k": "Direction", "v": "call", "c": getFigmaColor("C6E229")},
    {"k": "Time Period", "v": "08:29:17", "c": Colors.white},
    {"k": "Open Price", "v": "--", "c": Colors.white},
    {"k": "Amount", "v": "30", "c": Colors.white},
    {"k": "Open Position Time", "v": "2025/02/9 08:29:17", "c": Colors.white},
    {"k": "Turnover", "v": "30", "c": Colors.white},
    {"k": "Profit/Loss", "v": "31", "c": getFigmaColor("CA3F64")},
    {"k": "Rate of Return", "v": "87.20%", "c": Colors.white},
  ];

  List<Map> inviteMeMap = [
    {"k": "Title", "v": "NO. 1", "c": Colors.white},
    {"k": "Trading Pair", "v": null, "c": Colors.white},
    {"k": "Purchase Duration", "v": null, "c": Colors.white},
    {"k": "Release Time", "v": "2025/02/9 08:29:17", "c": Colors.white},
    {"k": "Order Amount", "v": "1.53", "c": Colors.white},
  ];

  @override
  void initState() {
    context
        .read<WalletSystemUserBalanceAndTradeCallingBloc>()
        .add(FetchUserTransactionsEvent());

    context
        .read<WalletSystemUserBalanceAndTradeCallingBloc>()
        .add(ListTradesAUserIsFollowingEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: buildBackArrow(context),
        ),
        leadingWidth: 76,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => OrderFollowedDialog(),
                );
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
              WalletSystemUserBalanceAndTradeCallingState>(
          listener: (context, state) {
        if (state is ListTradesAUserIsFollowingSuccessState) {
          state.listOfTradeEntities.forEach((element) {
            currentOrderEntities.add(TradeModel.fromEntity(element));
          });
        }
        if (state is ListTradesAUserIsFollowingErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
        if (state is FetchUserTransactionsSuccessState) {
          state.listOfOrderEntity.forEach((element) {
            historOrderEntities.add(OrderModel.fromEntity(element));
          });
        }
        if (state is FetchUserTransactionsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      }, builder: (context, state) {
        return Center(
          child: Padding(
            padding: externalPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFirstRow(),
                  _buildSecondRow(),
                  _buildThirdROw(),
                  const SizedBox(height: 20),
                  _buildBigChartWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(text: "Current Order (1)"),
                                Tab(text: "Historical Order"),
                                Tab(text: "Invited me"),
                                Tab(text: "Follow-plan"),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                _buildCurrentOrderTabview(),
                                SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      historOrderEntities.length,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 28.0),
                                          child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .7,
                                              child: _buildHistoryOrderTabview(
                                                  historOrderEntities[index])),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Container(
                                //   child: Text(Uuid().v4()),
                                // ),
                                _buildInviteMeTabview(),
                                Container(
                                  child: Text(Uuid().v4()),
                                ),
                              ]),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCurrentOrderTabview() {
    if (currentOrderEntities.isNotEmpty) {
      List latestOrderDetail =
          convertTradeEntityToMap(currentOrderEntities.first);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: latestOrderDetail.map((e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FancyText(
                e["k"],
                textColor: Colors.grey,
              ),
              FancyText(
                e["v"] ?? "--",
                textColor: e['c'],
              )
            ],
          );
        }).toList(),
      );
    } else {
      return buildEmptyWidget("No Current Order Yet");
    }
  }

  Column _buildHistoryOrderTabview(OrderModel orderModel) {
    List thaList = convertOrderEntityToMap(orderModel);
    // historOrderEntities.map((e) => ).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: thaList
          .map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FancyText(
                  e["k"],
                  textColor: Colors.grey,
                ),
                FancyText(
                  e["v"] ?? "--",
                  textColor: e['c'],
                )
              ],
            ),
          )
          .toList(),
    );
  }

  Column _buildInviteMeTabview() {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FancyContainerTwo(
                height: 40,
                hasBorder: true,
                borderColor: Colors.white.withAlpha(10),
                backgroundColor: getFigmaColor("151517"),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyText(
                    "Initiate a follow-up order".toCurrentLanguage(),
                    // size: 10,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: FancyContainerTwo(
                height: 40,
                hasBorder: true,
                borderColor: Colors.white.withAlpha(10),
                backgroundColor: getFigmaColor("151517"),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyText(
                    "Initiate a follow-up order".toCurrentLanguage(),
                    // size: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FancyContainerTwo(
          height: 40,
          width: double.infinity,
          borderColor: Colors.white.withAlpha(10),
          backgroundColor: getFigmaColor("151517"),
          hasBorder: true,
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: "Enter Order Code",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              FancyContainerTwo(
                height: 40,
                width: 100,
                action: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmOrderDialog(),
                  );
                },
                borderColor: Colors.white.withAlpha(10),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(0), right: Radius.circular(10)),
                backgroundColor: getFigmaColor("38393D"),
                hasBorder: true,
                child: FancyText(
                  "Confirm".toCurrentLanguage(),
                  textColor: getFigmaColor("707070"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: inviteMeMap
                .map(
                  (e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FancyText(
                        e["k"],
                        textColor: Colors.grey,
                      ),
                      FancyText(
                        e["v"] ?? "--",
                        textColor: e['c'],
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  FancyContainerTwo _buildBigChartWidget() {
    return FancyContainerTwo(
      backgroundColor: getFigmaColor("151517"),
      // Colors.grey.withAlpha(20),
      height: 400,
      width: double.infinity,
      child: DefaultTabController(
          length: 1,
          child: Column(
            children: [
              const TabBar(
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Chart',
                      // icon: Icon(Icons.home)
                    ),
                    // Tab(
                    //   text: 'Overview',
                    //   // icon: Icon(Icons.settings)
                    // ),
                    // Tab(text: 'Tab 3', icon: Icon(Icons.person)),
                  ]),
              FancyContainerTwo(
                height: 50,
                width: double.infinity,
                // backgroundColor: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ...["1min", "5min"]
                              .map(
                                (e) => _buildTimeSelectButton(e),
                              )
                              .toList(),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                      Row(
                        children: [
                          // const SizedBox(width: 20),
                          _buildIsDepthOrOriginalWidget(),
                          const SizedBox(width: 20),
                          const Icon(Icons.expand),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                // height: 100,
                child: TabBarView(children: [
                  // CandleStickChart(),
                  CandleStickChart(
                      // chartDetails: chartDetails ??
                      //     {
                      //       "symbol": "BTCUSDT",
                      //       "period": period,
                      //       "askAndBids": {}
                      //     },
                      )
                  // Center(child: Text('Content of Tab 1')),
                  // const Center(child: Text('Content of Tab 2')),
                ]),
              ),
            ],
          )),
    );
  }

  Map? chartDetails = {};
  String period = "1";

  FancyContainerTwo _buildIsDepthOrOriginalWidget() {
    return FancyContainerTwo(
      backgroundColor: getFigmaColor("1D1D1D"),
      // Colors.grey.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            FancyContainerTwo(
              height: 30,
              width: 60,
              action: () {
                isDepth = false;
                setState(() {});
              },
              backgroundColor: isDepth ? null : getFigmaColor("383838"),
              child: FancyText(
                "Original".toCurrentLanguage(),
                size: 12,
              ),
            ),
            FancyContainerTwo(
              action: () {
                isDepth = true;
                setState(() {});
              },
              height: 30,
              width: 60,
              backgroundColor: !isDepth ? null : getFigmaColor("383838"),
              child: FancyText(
                "Depth".toCurrentLanguage(),
                size: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  String selectedTimeText = "5min";
  FancyContainerTwo _buildTimeSelectButton(String text) {
    return FancyContainerTwo(
      action: () {
        selectedTimeText = text;

        period = selectedTimeText[0];
        chartDetails = {
          "symbol": "BTCUSDT",
          "period": period,
          "askAndBids": {}
        };
        context.read<WebSocketBloc>().add(
              SubscribeToCryptoEvent(
                  interval: period.toUpperCase(),
                  symbol: selectedCoinModel?.symbol ?? "BTC"),
            );

        setState(() {});
      },
      width: 60,
      height: 30,
      radius: 5,
      backgroundColor:
          selectedTimeText == text ? Colors.grey.withAlpha(20) : null,
      child: FancyText(
        text,
        textColor: selectedTimeText == text ? null : Colors.grey.withAlpha(100),
      ),
    );
  }

  Row _buildThirdROw() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            FancyText(
              "Order Deadline".toCurrentLanguage(),
              textColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            FancyText(
              "2025/01/19 20:00:05",
              // textColor: Colors.grey,
            ),
          ],
        ),
        Column(
          children: [
            FancyText(
              "Countdown".toCurrentLanguage(),
              textColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            FancyText(
              "223s",
              textColor: getFigmaColor("F0C163"),
            ),
          ],
        ),
        Column(
          children: [
            FancyText(
              "Time Period".toCurrentLanguage(),
              textColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            FancyText(
              "12:50 - 12.55",
              // textColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  Row _buildSecondRow() {
    return Row(
      children: ["5 min", "1 hr"]
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: RadioButton(
                isHignlighted: selectedMinute == e,
                text: e,
                radius: 2,
                onclick: (text) {
                  selectedMinute = e;
                  setState(() {});
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 2,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  CoinModel? selectedCoinModel;

  Row _buildFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FancyContainerTwo(
              hasBorder: true,
              radius: 7,
              borderColor: getFigmaColor("2B3139"),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.star_rate_rounded,
                  size: 15.w,
                  color: getFigmaColor("F0B90B"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            DropdownButtonHideUnderline(
                child: DropdownButton2(
              dropdownStyleData: const DropdownStyleData(width: 200),
              customButton: Row(
                children: [
                  Text(
                    (selectedCoinModel?.symbol != null)
                        ? "${selectedCoinModel!.symbol}USDT"
                        : "select a coin".toCurrentLanguage(),
                    style: TextStyle(
                      color: getFigmaColor("EAECEF"),
                      fontSize: 24.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10 / 2),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: getFigmaColor("848E9C"),
                  ),
                ],
              ),
              //  IconButton(
              //     onPressed: () {}, icon: ),
              items: listOfCoinEntityG.map((e) {
                return DropdownMenuItem(
                  value: "${e.symbol}USDT",
                  onTap: () {
                    selectedCoinModel = CoinModel.fromEntity(e);
                    selectedText = "${selectedCoinModel!.symbol}USDT";
                    chartDetails = {
                      "symbol": "$selectedText",
                      "period": period,
                      "askAndBids": {}
                    };
                    context.read<WebSocketBloc>().add(
                          SubscribeToCryptoEvent(
                              interval: period.toUpperCase(),
                              symbol: selectedCoinModel!.symbol),
                        );
                    // selectedCoinModel?.symbol;
                    setState(() {});
                  },
                  child: Text(
                    "${e.symbol}USDT",
                    style: TextStyle(
                      color: getFigmaColor("EAECEF"),
                      fontSize: 24.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              value: selectedText,
              onChanged: (value) {},
            ))
          ],
        ),
        BlocConsumer<WebSocketBloc, WebSocketState>(listener: (context, state) {
          if (state is WebSocketDataState) {
            final decodedData = jsonDecode(state.data);
            if ((decodedData["topic"] as String?)?.startsWith("kline.") ??
                false) {}
            try {} catch (e) {}
          }
          if (state is WebSocketConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("connected".toCurrentLanguage()),
                backgroundColor: Colors.green,
              ),
            );
          }
          // state;
        }, builder: (context, state) {
          return Row(
            children: [
              FancyText(
                "${cad["currentPrice"] ?? ""}",
                textColor: ColorConstants.fancyGreen,
                size: 16.w,
              ),
              // ("96191.9"),
              const SizedBox(width: 4),
              // "${(cad?["percentageChange"] ?? "")} (${cad?["valueChange"] ?? ""}) "
              FancyText(
                (cad["percentageChange"] != null)
                    ? "${cad["percentageChange"] ?? ""}%"
                    : "",
                textColor: ColorConstants.fancyGreen,
                size: 16.w,
              ),
              // Text("+0.12%"),
            ],
          );
        })
      ],
    );
  }

  Map cad = {};
  String selectedMinute = "5min";
}
