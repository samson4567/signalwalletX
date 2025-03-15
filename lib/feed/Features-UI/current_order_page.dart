import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/feed/Features-UI/components/confirm_order_dialog.dart';
import 'package:signalwavex/feed/Features-UI/components/order_followed_dialog.dart';
import 'package:signalwavex/component/back_button.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/component/radio_button.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';
import 'package:signalwavex/main.dart';
import 'package:signalwavex/testScreen/candle_stick_chart.dart';
import 'package:uuid/uuid.dart';

class FeaturesCurrentOrder extends StatefulWidget {
  const FeaturesCurrentOrder({super.key});

  @override
  State<FeaturesCurrentOrder> createState() => _FeaturesCurrentOrderState();
}

class _FeaturesCurrentOrderState extends State<FeaturesCurrentOrder> {
  EdgeInsets externalPadding = const EdgeInsets.symmetric(horizontal: 20);
  String selectedText = "Perp";
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
      body: Center(
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
                                  children: List.filled(
                                      3,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 28.0),
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .7,
                                            child: _buildHistoryOrderTabview()),
                                      )),
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
      ),
    );
  }

  Column _buildCurrentOrderTabview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: currentOrderMap
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

  Column _buildHistoryOrderTabview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: historOrderMap
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
                    "Initiate a follow-up order",
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
                    "Initiate a follow-up order",
                    // size: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        FancyContainerTwo(
          height: 40,
          width: double.infinity,
          borderColor: Colors.white.withAlpha(10),
          backgroundColor: getFigmaColor("151517"),
          hasBorder: true,
          child: Row(
            children: [
              Expanded(
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
                  "Confirm",
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
          length: 2,
          child: Column(
            children: [
              const TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Chart',
                      // icon: Icon(Icons.home)
                    ),
                    Tab(
                      text: 'Overview',
                      // icon: Icon(Icons.settings)
                    ),
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
                          ...["60s", "5min"]
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
                  CandleStickChart(),
                  // Center(child: Text('Content of Tab 1')),
                  const Center(child: Text('Content of Tab 2')),

                  // Container(
                  //   color: Colors.green,
                  //   width: double.infinity,
                  //   height: 200,
                  // ),
                  // Container(
                  //   color: Colors.red,
                  //   width: double.infinity,
                  //   height: 200,
                  // ),
                ]),
              ),
            ],
          )),
    );
  }

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
              child: FancyText(
                "Original",
                size: 12,
              ),
              backgroundColor: isDepth ? null : getFigmaColor("383838"),
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
                "Depth",
                size: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  String selectedTimeText = "15 min";
  FancyContainerTwo _buildTimeSelectButton(String text) {
    return FancyContainerTwo(
      action: () {
        selectedTimeText = text;
        setState(() {});
      },
      width: 60,
      height: 30,
      radius: 5,
      child: FancyText(
        text,
        textColor: selectedTimeText == text ? null : Colors.grey.withAlpha(100),
      ),
      backgroundColor:
          selectedTimeText == text ? Colors.grey.withAlpha(20) : null,
    );
  }

  Row _buildThirdROw() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            FancyText(
              "Order Deadline",
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
              "Countdown",
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
              "Time Period",
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
        Row(
          children: [
            FancyText(
              "96191.9",
              textColor: ColorConstants.fancyGreen,
              size: 16.w,
            ),
            // ("96191.9"),
            const SizedBox(width: 4),
            FancyText(
              "+0.12%",
              textColor: ColorConstants.fancyGreen,
              size: 16.w,
            ),
            // Text("+0.12%"),
          ],
        )
      ],
    );
  }

  String selectedMinute = "5min";
}
