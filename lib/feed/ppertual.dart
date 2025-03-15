import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/component/flow_amination_screen.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';
import 'package:signalwavex/testScreen/candle_stick_chart.dart';

class PerpetualScreen extends StatefulWidget {
  const PerpetualScreen({super.key});

  @override
  State<PerpetualScreen> createState() => _PerpetualScreenState();
}

class _PerpetualScreenState extends State<PerpetualScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerComponent(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: 20,
            ),
            Text("back"),
          ],
        ),
        title: const Text(
          "Perpetual Trading",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open drawer correctly
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Center(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                _buildFirstRow(),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FancyContainerTwo(
                        height: 600,
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                tabAlignment: TabAlignment.start,
                                isScrollable: true,
                                dividerColor: getFigmaColor("27282B"),
                                tabs: [
                                  Tab(
                                    // text: "limit",
                                    child: FancyText(
                                      "limit",
                                      size: 10,
                                    ),
                                  ),
                                  Tab(
                                    child: FancyText(
                                      "Market",
                                      size: 10,
                                    ),
                                    // text: "Market"
                                  ),
                                  Tab(
                                    child: FancyText(
                                      "TP/SL",
                                      size: 10,
                                    ),
                                    // text: "TP/SL",
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  _buildLimitTabView(),
                                  _buildLimitTabView(),
                                  _buildLimitTabView(),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Container(
                      // color: Colors.red,
                      child: _buildTheTabledSection(),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (tpOrslIsChecked) _buildPositionAndTradeTabView(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  FancyContainerTwo _buildPositionAndTradeTabView() {
    return FancyContainerTwo(
      height: 450,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              dividerColor: getFigmaColor("27282B"),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: const [
                Tab(text: "Position"),
                Tab(text: "Trades"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                _buildPositionTabBarView(),
                _buildTradesTabBarView()
              ]),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildTradesTabBarView() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          FancyContainerTwo(
            hasBorder: true,
            borderColor: Colors.white.withOpacity(.1),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Row(
                          children: [
                            FancyText(
                              "ETHUSDT",
                              textColor: getFigmaColor("FFFFFF", 60),
                              size: 14.w,
                            ),
                            SizedBox(width: 10),
                            FancyContainerTwo(
                              backgroundColor: getFigmaColor("0ECB81", 20),
                              radius: 5,
                              child: Padding(
                                padding: EdgeInsets.all(6.0.w),
                                child: FancyText(
                                  "Buy Long",
                                  textColor: ColorConstants.fancyGreen,
                                  size: 14.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Entry price",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "2491.04",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Profit(USDT)",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "+3.99",
                              textColor: getFigmaColor("C6E229"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Max Quantity",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "0.56",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Handling Fee",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "0.56",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Average Closing Price",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "100%",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Quantity",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "0.56 (ETH)",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Time",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "2025/2/25 02:16:09 (UTC+2)",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FancyText(
                              "Type",
                              textColor: getFigmaColor("FFFFFF", 60),
                            ),
                            FancyText(
                              "Close",
                              textColor: getFigmaColor("CED0D4"),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPositionTabBarView() {
    return Padding(
      padding: EdgeInsets.all(18.0.w),
      child: SizedBox(
        child: Column(
          children: [
            FancyContainerTwo(
              hasBorder: true,
              borderColor: Colors.white.withOpacity(.1),
              child: Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Row(
                            children: [
                              FancyText(
                                "ETHUSDT",
                                textColor: getFigmaColor("FFFFFF", 60),
                                size: 14.w,
                              ),
                              SizedBox(width: 10),
                              FancyContainerTwo(
                                backgroundColor: getFigmaColor("0ECB81", 20),
                                radius: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(6.0.w),
                                  child: FancyText(
                                    "Buy Long",
                                    textColor: ColorConstants.fancyGreen,
                                    size: 14.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Opening time",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "2025/2/25 02:16:09 (UTC+2)",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Quantity",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "0.56",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Profit(USDT)",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "+3.99",
                                textColor: getFigmaColor("C6E229"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Margin ratio",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "100%",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Margin",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "1394.99",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Entry price",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "2491.04",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FancyText(
                                "Est. liq. Price",
                                textColor: getFigmaColor("FFFFFF", 60),
                              ),
                              FancyText(
                                "124.54",
                                textColor: getFigmaColor("CED0D4"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(
              child: Row(
                children: [
                  FancyContainerTwo(
                    backgroundColor: getFigmaColor("222629"),
                    radius: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FancyText(
                        "+Increase margin",
                        textColor: ColorConstants.fancyGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FancyContainerTwo(
                    backgroundColor: getFigmaColor("222629"),
                    radius: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FancyText(
                        "TP/SL",
                        textColor: ColorConstants.fancyGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FancyContainerTwo(
                    backgroundColor: getFigmaColor("222629"),
                    radius: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FancyText(
                        "Close",
                        textColor: ColorConstants.fancyGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FancyContainerTwo(
                    backgroundColor: getFigmaColor("222629"),
                    radius: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FancyText(
                        "Close all",
                        textColor: ColorConstants.fancyGreen,
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

  Column _buildTheTabledSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTableHeader(),
        ...List.generate(
          20,
          (index) => _buildTableBodyRow(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyText(
              "96191.9",
              textColor: ColorConstants.fancyGreen,
              size: 16.w,
            ),
            // ("96191.9"),
            const SizedBox(width: 10),
            FancyText(
              "+0.12%",
              textColor: ColorConstants.fancyGreen,
              size: 16.w,
            ),
            // Text("+0.12%"),
          ],
        ),
        ...List.generate(
          10,
          (index) => _buildTableBodyRowGreenVersion(),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FancyText(
              "Price (USDT)",
              textColor: getFigmaColor("909090"),
              size: 10.w,
            ),
            FancyText(
              "Amount (BTC)",
              textColor: getFigmaColor("909090"),
              size: 10.w,
            ),
            FancyText(
              "Total (BTC)",
              textColor: getFigmaColor("909090"),
              size: 10.w,
            ),
          ],
        ),
        Divider(
          height: 2,
        )
      ],
    );
  }

  Widget _buildTableBodyRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: CandleStickChart(),
                ),
              ),
            ),
          );
        },
        child: SizedBox(
          height: 15,
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FancyText(
                      "91,973.0",
                      textColor: getFigmaColor("CA3F64"),
                      size: 10,
                    ),
                    FancyText(
                      "0.2550",
                      size: 10,
                    ),
                    FancyText(
                      "5.7867",
                      size: 7,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FancyContainerTwo(
                  radius: 1,
                  height: double.infinity,
                  width: Random().nextInt(200) / 1,
                  backgroundColor: getFigmaColor("CA3F64", 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableBodyRowGreenVersion() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: SizedBox(
        height: 15,
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FancyText(
                    "91,973.0",
                    textColor: ColorConstants.fancyGreen,
                    size: 10,
                  ),
                  FancyText(
                    "0.2550",
                    size: 10,
                  ),
                  FancyText(
                    "5.7867",
                    size: 7,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FancyContainerTwo(
                radius: 1,
                height: double.infinity,
                width: Random().nextInt(200) / 1,
                backgroundColor: getFigmaColor("25A750", 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildLimitTabView() {
    return Column(
      children: [
        /// price slab
        _buildPriceSlab(),

        /// amount slab
        _buildAmountSlab(),

        /// progress slab
        _buildProgressSlab(),

        /// available and max buy ui
        _buildavailableAndMaxBuy(),

        SizedBox(height: 10),

        /// reduce only and TP/SL  check boxes and the divider ui
        _buildReduceOnlyTPSLCheckBoxesAndDIvider(), SizedBox(height: 10),
        _buildtriggerPriceSlab(),
        _buildtriggerPriceSlab(hint: "SL trigger price (USDT)"),
        SizedBox(height: 10),
        _buildBuySellColumn(),
        SizedBox(height: 10),
        _buildMarginMaxAndLiquidPrice(),
      ],
    );
  }

  Column _buildBuySellColumn() {
    return Column(
      children: [
        FancyContainerTwo(
          height: 32,
          width: double.infinity,
          backgroundColor: ColorConstants.fancyGreen,
          child: FancyText(
            "Buy (Long)",
            textColor: Colors.black,
            size: 10,
            weight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        FancyContainerTwo(
          height: 32,
          width: double.infinity,
          backgroundColor: getFigmaColor("CA3F64"),
          child: FancyText(
            "Sell (Short)",
            // textColor: Colors.black,
            size: 10,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Column _buildReduceOnlyTPSLCheckBoxesAndDIvider() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: FittedBox(
                child: Checkbox(
                  // checkColor: ColorConstants.fancyGreen,
                  splashRadius: 20,
                  value: reduceOnlyIsChecked,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(
                      color: getFigmaColor("4D4D4D"),
                    ),
                  ),
                  side: BorderSide(
                    width: 2,
                    color: getFigmaColor("4D4D4D"),
                  ),
                  onChanged: (value) {
                    reduceOnlyIsChecked = value ?? false;
                    setState(() {});
                  },
                ),
              ),
            ),
            FancyText(
              "Reduce-only",
              weight: FontWeight.w400,
              size: 10,
              textColor: getFigmaColor("E6E6E6"),
            )
          ],
        ),
        Divider(
          color: getFigmaColor("2E2E2E"),
          thickness: 1,
        ),
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: FittedBox(
                child: Checkbox(
                  // checkColor: ColorConstants.fancyGreen,
                  splashRadius: 20,
                  value: tpOrslIsChecked,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(
                      color: getFigmaColor("4D4D4D"),
                    ),
                  ),
                  side: BorderSide(
                    width: 2,
                    color: getFigmaColor("4D4D4D"),
                  ),
                  onChanged: (value) {
                    tpOrslIsChecked = value ?? false;
                    setState(() {});
                  },
                ),
              ),
            ),
            FancyText(
              "TP/SL",
              weight: FontWeight.w400,
              size: 10,
              textColor: getFigmaColor("E6E6E6"),
            )
          ],
        )
      ],
    );
  }

  Padding _buildPriceSlab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FancyContainerTwo(
        height: 32,
        backgroundColor: getFigmaColor("1D1D1D"),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(bottom: 18),
                    hintText: "Price",
                    hintStyle: TextStyle(
                      color: getFigmaColor("B0B0B0"),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              FancyText(
                "91,997.3 USDT",
                weight: FontWeight.w400,
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildSLtriggerPriceSlab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FancyContainerTwo(
        height: 32,
        backgroundColor: getFigmaColor("1D1D1D"),
        // backgroundColor: Colors.white.withAlpha(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  // textAlign: ,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.red,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(bottom: 18),
                    hintText: "TP trigger price (USDT)",
                    hintStyle: TextStyle(
                      color: getFigmaColor("B0B0B0"),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildtriggerPriceSlab({String hint = "TP trigger price (USDT)"}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FancyContainerTwo(
        height: 32,
        backgroundColor: getFigmaColor("1D1D1D"),
        // backgroundColor: Colors.white.withAlpha(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  // textAlign: ,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.red,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(bottom: 18),
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: getFigmaColor("B0B0B0"),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildAmountSlab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FancyContainerTwo(
        height: 32,
        backgroundColor: getFigmaColor("1D1D1D"),
        // backgroundColor: Colors.white.withAlpha(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  // textAlign: ,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.red,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(bottom: 18),
                    hintText: "Price",
                    hintStyle: TextStyle(
                      color: getFigmaColor("B0B0B0"),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildCryptoCurrencyDropDownButton()
            ],
          ),
        ),
      ),
    );
  }

  FancyContainerTwo _buildProgressSlab() {
    return FancyContainerTwo(
      // backgroundColor: getFigmaColor("1D1D1D"),
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlowWidget(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0"),
              Text("100"),
            ],
          )
        ],
      ),
    );
  }

  Column _buildMarginMaxAndLiquidPrice() {
    return Column(
      children: [
        Row(
          children: [
            FancyText(
              "Margin ",
              textColor: getFigmaColor("909090"),
              size: 9,
            ),
            FancyText(
              "-- USDT",
              size: 9,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            FancyText(
              "Max Price ",
              textColor: getFigmaColor("909090"),
              size: 9,
            ),
            FancyText(
              "92,422.8",
              size: 9,
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: FancyText(
            "Liq. price",
            textColor: getFigmaColor("909090"),
            size: 9,
          ),
        ),
      ],
    );
  }

  Column _buildavailableAndMaxBuy() {
    return Column(
      children: [
        Row(
          children: [
            FancyText(
              "Available ",
              textColor: getFigmaColor("909090"),
              size: 9,
            ),
            FancyText(
              "0.00 USDT",
              size: 9,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            FancyText(
              "Max Buy ",
              textColor: getFigmaColor("909090"),
              size: 9,
            ),
            FancyText(
              "0.00 BTC",
              size: 9,
            ),
          ],
        )
      ],
    );
  }

  bool reduceOnlyIsChecked = false;
  bool tpOrslIsChecked = false;

  String? selectedCryptoCurrency = "BTC";
  DropdownButtonHideUnderline _buildCryptoCurrencyDropDownButton() {
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      dropdownStyleData: const DropdownStyleData(width: 200),
      // customButton: Icon(
      //   Icons.arrow_drop_down_rounded,
      //   color: getFigmaColor("848E9C"),
      // ),
      //  IconButton(
      //     onPressed: () {}, icon: ),
      items: [
        DropdownMenuItem(
          value: "BTC",
          onTap: () {
            if (selectedCryptoCurrency != "BTC") {
              selectedCryptoCurrency = "BTC";
            }
            // else {
            // selectedCryptoCurrency = null;
            // }

            setState(() {});
          },
          child: FancyText(
            "BTC",
            weight: FontWeight.w400,
            size: 12,
          ),
        ),
        DropdownMenuItem(
          value: "BTC_2",
          onTap: () {
            if (selectedCryptoCurrency != "BTC_2") {
              selectedCryptoCurrency = "BTC_2";
            }
            //  else {
            //   selectedCryptoCurrency = null;
            // }

            setState(() {});
          },
          child: FancyText(
            "BTC_2",
            weight: FontWeight.w400,
            size: 12,
          ),
        )
      ],
      value: selectedCryptoCurrency,
      onChanged: (value) {},
    ));
  }

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
            Text(
              "BTCUSDT",
              style: TextStyle(
                color: getFigmaColor("EAECEF"),
                fontSize: 24.w,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10 / 2),
            FancyContainerTwo(
              backgroundColor: Colors.grey,
              radius: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
                child: Text(
                  "${selectedText}",
                  style: TextStyle(
                    color: getFigmaColor("EAECEF"),
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            DropdownButtonHideUnderline(
                child: DropdownButton2(
              dropdownStyleData: const DropdownStyleData(width: 200),
              customButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: getFigmaColor("848E9C"),
              ),
              //  IconButton(
              //     onPressed: () {}, icon: ),
              items: [
                DropdownMenuItem(
                  value: "Perp",
                  onTap: () {
                    if (selectedText != "Perp") {
                      selectedText = "Perp";
                    }
                    // else {
                    // selectedText = null;
                    // }

                    setState(() {});
                  },
                  child: const Text(
                    "Perp",
                  ),
                ),
                DropdownMenuItem(
                  value: "Perp_2",
                  onTap: () {
                    if (selectedText != "Perp_2") {
                      selectedText = "Perp_2";
                    }
                    //  else {
                    //   selectedText = null;
                    // }

                    setState(() {});
                  },
                  child: const Text(
                    "Perp_2",
                  ),
                )
              ],
              value: selectedText,
              onChanged: (value) {},
            ))
          ],
        ),
      ],
    );
  }

  String selectedText = "Perp";
}



// class MyTableRow implements TableRow{
  // @override
  // // TODO: implement children
  // List<Widget> get children => throw UnimplementedError();

  // @override
  // // TODO: implement decoration
  // Decoration? get decoration => throw UnimplementedError();

  // @override
  // // TODO: implement key
  // LocalKey? get key => throw UnimplementedError();
  
// }