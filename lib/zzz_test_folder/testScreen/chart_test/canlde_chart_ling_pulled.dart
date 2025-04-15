import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';

class CanldeChartLongPulled extends StatefulWidget {
  CanldeChartLongPulled({Key? key, this.title, this.chartDetails})
      : super(key: key);

  final String? title;
  // final Map? askAndBids;
  Map? chartDetails;

  @override
  _CanldeChartLongPulledState createState() => _CanldeChartLongPulledState();
}

class _CanldeChartLongPulledState extends State<CanldeChartLongPulled> {
  List<KLineEntity>? datas;
  List<KLineEntity>? stableDatas;

  bool showLoading = true;
  MainState _mainState = MainState.NONE;
  bool _volHidden = true;
  SecondaryState _secondaryState = SecondaryState.NONE;
  bool isLine = true;
  bool isChinese = true;
  bool _hideGrid = true;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = false;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.left;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();
  Map tick = {};

  Map formatAskBid(Map askBid) {
    Map bids = askBid["bids"] ?? {};
    Map asks = askBid["asks"] ?? {};
    List newBids = [];
    List newAsks = [];

    bids.forEach(
      (key, value) => newBids.add([double.parse(key), double.parse(value)]),
    );
    asks.forEach(
      (key, value) => newAsks.add([double.parse(key), double.parse(value)]),
    );
    askBid["asks"] = newAsks;
    askBid["bids"] = newBids;
    return askBid;
  }

  bool isLoading = false;

  @override
  void initState() {
    context
        .read<WebSocketBloc>()
        .add(WebSocketConnectEvent("wss://stream.bybit.com/v5/public/linear"));
    super.initState();
    getDataOld();
    getData();

    if (widget.chartDetails?["askAndBids"] == null) {
      rootBundle.loadString('assets/depth.json').then((result) {
        final parseJson = json.decode(result);
        tick = parseJson['tick'] as Map<String, dynamic>;
        final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
            .map<DepthEntity>(
                (item) => DepthEntity(item[0] as double, item[1] as double))
            .toList();
        final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
            .map<DepthEntity>(
                (item) => DepthEntity(item[0] as double, item[1] as double))
            .toList();
        initDepth(bids, asks);
      });
    } else {
      tick = formatAskBid(widget.chartDetails!["askAndBids"]);
      final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      initDepth(bids, asks);
    }
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    });

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    });
    setState(() {});
  }

  String? formerPeriod;
  String? formerSymbol;

  @override
  Widget build(BuildContext context) {
    if (formerPeriod != widget.chartDetails?["period"] ||
        formerSymbol != widget.chartDetails?["symbol"]) {
      // print(formerPeriod != widget.chartDetails?["period"]);
      getData();
      formerPeriod = widget.chartDetails?["period"];
      formerSymbol = widget.chartDetails?["symbol"];
    }

    chartColors.lineFillColor = ColorConstants.fancyGreen;
    chartColors.kLineColor = ColorConstants.fancyGreen;

    // chartColors.lineFillInsideColor = ColorConstants.fancyGreen;
// solveChatData
    return BlocConsumer<WebSocketBloc, WebSocketState>(
        listener: (context, state) {
      if (state is SubscribeToCryptoSuccessState) {
        print("debug_print_linechart-SubscribeToCryptoSuccessState-start");
        solveChatData(state.data);
        print(
            "debug_print_linechart-SubscribeToCryptoSuccessState-solveChatData-ended");
      } else if (state is WebSocketDataState) {
        solveChatData(state.data);
        print("debug_print_linechart-SubscribeToCryptoSuccessState-start");
        print(
            "debug_print_linechart-SubscribeToCryptoSuccessState-solveChatData-ended");
      } else if (state is WebSocketErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, builder: (context, state) {
      print("debug_print_linechart-building");
      print("debug_print_linechart-building${state}");

      return Container(
        child: Stack(children: <Widget>[
          FancyContainer(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(.1)),
            height: 450,
            // width: 450,
            width: double.infinity,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  //  isLoading
                  //     ? const Center(
                  //         child: CircularProgressIndicator.adaptive(),
                  //       )
                  //     :
                  KChartWidget(
                stableDatas,
                chartStyle,
                chartColors,
                isLine: false,
                // isLine: isLine,

                onSecondaryTap: () {
                  print('Secondary Tap');
                },
                isTrendLine: _isTrendLine,
                mainState: _mainState,
                volHidden: true,
                secondaryState: _secondaryState,
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,
                translations: kChartTranslations,
                showNowPrice: _showNowPrice,
                //`isChinese` is Deprecated, Use `translations` instead.
                // isChinese: isChinese,
                hideGrid: true,
                isTapShowInfoDialog: false,
                verticalTextAlignment: _verticalTextAlignment,
                maDayList: [1, 100, 1000],
              ),
            ),
          ),

          // if (showLoading)
          //   Container(
          //       width: double.infinity,
          //       height: 450,
          //       alignment: Alignment.center,
          //       child: const CircularProgressIndicator()),
        ]),
      );
    });
  }

  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button("Time Mode", onPressed: () => isLine = true),
        button("K Line Mode", onPressed: () => isLine = false),
        button("TrendLine", onPressed: () => _isTrendLine = !_isTrendLine),
        button("Line:MA", onPressed: () => _mainState = MainState.MA),
        button("Line:BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("Hide Line", onPressed: () => _mainState = MainState.NONE),
        button("Secondary Chart:MACD",
            onPressed: () => _secondaryState = SecondaryState.MACD),
        button("Secondary Chart:KDJ",
            onPressed: () => _secondaryState = SecondaryState.KDJ),
        button("Secondary Chart:RSI",
            onPressed: () => _secondaryState = SecondaryState.RSI),
        button("Secondary Chart:WR",
            onPressed: () => _secondaryState = SecondaryState.WR),
        button("Secondary Chart:CCI",
            onPressed: () => _secondaryState = SecondaryState.CCI),
        button("Secondary Chart:Hide",
            onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? "Show Vol" : "Hide Vol",
            onPressed: () => _volHidden = !_volHidden),
        button("Change Language", onPressed: () => isChinese = !isChinese),
        button(_hideGrid ? "Show Grid" : "Hide Grid",
            onPressed: () => _hideGrid = !_hideGrid),
        button(_showNowPrice ? "Hide Now Price" : "Show Now Price",
            onPressed: () => _showNowPrice = !_showNowPrice),
        button("Customize UI", onPressed: () {
          setState(() {
            isChangeUI = !isChangeUI;
            if (isChangeUI) {
              chartColors.selectBorderColor = Colors.red;
              chartColors.selectFillColor = Colors.red;
              chartColors.lineFillColor = Colors.red;
              chartColors.kLineColor = Colors.yellow;
            } else {
              chartColors.selectBorderColor = const Color(0xff6C7A86);
              chartColors.selectFillColor = const Color(0xff0D1722);
              chartColors.lineFillColor = const Color(0x554C86CD);
              chartColors.kLineColor = const Color(0xff4C86CD);
            }
          });
        }),
        button("Change PriceTextPaint",
            onPressed: () => setState(() {
                  _priceLeft = !_priceLeft;
                  if (_priceLeft) {
                    _verticalTextAlignment = VerticalTextAlignment.left;
                  } else {
                    _verticalTextAlignment = VerticalTextAlignment.right;
                  }
                })),
      ],
    );
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      child: Text(text),
      style: TextButton.styleFrom(
        // primary: Colors.white,
        minimumSize: const Size(88, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void getData() {
    isLoading = true;
    setState(() {});

    context.read<WebSocketBloc>().add(SubscribeToCryptoEvent(
          interval: widget.chartDetails?["period"] ?? "5",
          symbol: widget.chartDetails?["symbol"] ?? "BTC",
        ));
    // /*
    //  * 可以翻墙使用方法1加载数据，不可以翻墙使用方法2加载数据，默认使用方法1加载最新数据
    //  */
    // final Future<String> future = getChatDataFromInternet(period);
    // //final Future<String> future = getChatDataFromJson();
    // future.then((String result) {
    //   solveChatData(result);
    // }).catchError((_) {
    //   showLoading = false;
    //   setState(() {});
    //   print('### datas error $_');
    // });
    isLoading = false;
    setState(() {});
  }

  void getDataOld() {
    print("debug_print_linechart-getDataOld-start");
    isLoading = true;
    setState(() {});

    /*
     * 可以翻墙使用方法1加载数据，不可以翻墙使用方法2加载数据，默认使用方法1加载最新数据
     */
    final Future<String> future = getChatDataFromInternet();
    //final Future<String> future = getChatDataFromJson();
    future.then((String result) {
      print(
          "debug_print_linechart-getDataOld-getChatDataFromInternet-done${result}");

      solveChatData(arrangeDataForDisplay(result), fromSingleFetch: true);
      print(
          "debug_print_linechart-getDataOld-solveChatData-done${stableDatas?.length}");
    }).catchError((_) {
      print("debug_print_linechart-getDataOld-error_is_${_}");

      showLoading = false;
      setState(() {});
      print('### datas error $_');
    });
    isLoading = false;
    setState(() {});
    print("debug_print_linechart-getDataOld-success");
  }

  String arrangeDataForDisplay(String data) {
    // this is to reformat the list into map
    Map decodedData = jsonDecode(data);
    List rawListOfUsableData = decodedData['result']["list"];
    List treatedListOfUsableData = [];
    rawListOfUsableData.forEach(
      (element) {
        // {start: 1744682400000, end: 1744682699999, interval: 5,
        //  open: 84935.5, close: 84933, high: 84975,
        // low: 84881.9, volume: 35.206, turnover: 2990181.6381,
        // confirm: false, timestamp: 1744682518560,}
        List item = element;
        treatedListOfUsableData.add({
          "start": item[0],
          "end": null,
          "interval": null,
          "open": item[1],
          "close": item[4],
          "high": item[2],
          "low": item[3],
          "volume": item[5],
          "turnover": item[6],
          "confirm": true,
          "timestamp": item[0],
        });
      },
    );
    decodedData["data"] = treatedListOfUsableData;
    return jsonEncode(decodedData);
  }

  //获取火币数据，需要翻墙
  Future<String> getChatDataFromInternet() async {
    String usablePeriod = '1day';
    if (widget.chartDetails?["period"] == "1") {
      usablePeriod = "1min";
    }
    if (widget.chartDetails?["period"] == "3") {
      usablePeriod = "3min";
    }
    if (widget.chartDetails?["period"] == "5") {
      usablePeriod = "5min";
    }
    if (widget.chartDetails?["period"] == "D") {
      usablePeriod = "1day";
    }
    if (widget.chartDetails?["period"] == "M") {
      usablePeriod = "1mon";
    }
    if (widget.chartDetails?["period"] == "Y") {
      usablePeriod = "1year";
    }
    var url =
        'https://api.huobi.br.com/market/history/kline?period=$usablePeriod&size=300&symbol=${(widget.chartDetails?["symbol"] as String?)?.toLowerCase() ?? "BTCUSDT".toLowerCase()}';
    'https://api.huobi.br.com/market/history/kline?period=1day&size=300&symbol=btcusdt';

    String startDateStamp = DateTime.now()
        .subtract(Duration(days: 1))
        .millisecondsSinceEpoch
        .toString();
    if (widget.chartDetails?["period"] == "1") {
      startDateStamp = DateTime.now()
          .subtract(Duration(minutes: 1 * 3))
          .millisecondsSinceEpoch
          .toString();
    }
    if (widget.chartDetails?["period"] == "3") {
      startDateStamp = DateTime.now()
          .subtract(Duration(minutes: 1 * 3))
          .millisecondsSinceEpoch
          .toString();
    }
    if (widget.chartDetails?["period"] == "5") {
      startDateStamp = DateTime.now()
          .subtract(Duration(minutes: 5 * 3))
          .millisecondsSinceEpoch
          .toString();
    }
    if (widget.chartDetails?["period"] == "D") {
      startDateStamp = DateTime.now()
          .subtract(Duration(days: 1 * 3))
          .millisecondsSinceEpoch
          .toString();
    }
    if (widget.chartDetails?["period"] == "M") {
      startDateStamp = DateTime.now()
          .subtract(Duration(days: 30 * 2))
          .millisecondsSinceEpoch
          .toString();
    }
    if (widget.chartDetails?["period"] == "Y") {
      startDateStamp = DateTime.now()
          .subtract(Duration(days: 365 * 2))
          .millisecondsSinceEpoch
          .toString();
    }
    url =
        // "http://api-testnet.bybit.com/v5/market/kline?category=inverse&symbol=${widget.chartDetails?["symbol"] ?? "BTC"}USD&interval=60&start=${startDateStamp}&end=${DateTime.now().millisecondsSinceEpoch}";
        "http://api-testnet.bybit.com/v5/market/kline?symbol=${widget.chartDetails?["symbol"] ?? "BTC"}USD&interval=${widget.chartDetails?["period"] ?? "60"}&start=${startDateStamp}&end=${DateTime.now().millisecondsSinceEpoch}";

    print("debug_print_linechart-getChatDataFromInternet-url_is=$url");
    late String result;
    final response = await http.get(Uri.parse(url));
    print("debug_print_linechart-getChatDataFromInternet-http.get_done");
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

  // 如果你不能翻墙，可以使用这个方法加载数据
  Future<String> getChatDataFromJson() async {
    return rootBundle.loadString('chatData.json');
  }

  void solveChatData(String result, {bool fromSingleFetch = false}) {
    print("debug_print_linechart-solveChatData-start");
    print(
        "debug_print_linechart-solveChatData-start_with_input_fromSingleFetch_${fromSingleFetch}");

    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    print("debug_print_linechart-solveChatData-parseJson_is=$parseJson");
    if (!fromSingleFetch) {
      if (!parseJson["topic"].toString().startsWith("kline.")) {
        return;
      }
    }
    final list = parseJson['data'] as List<dynamic>;
    print("debug_print_linechart-solveChatData-list_is=$list");
    print("fromSingleFetch_is=$fromSingleFetch");
    datas = list
        .map((item) =>
            // ((fromSingleFetch)
            //     ? KLineEntity.fromJson(item as Map<String, dynamic>)
            //     :
            getKLineEntityFromMap(item as Map<String, dynamic>))
        //  )
        // KLineEntity.fromJson(item as Map<String, dynamic>))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();
    try {
      if (fromSingleFetch) {
        print("sdjkasjdabajb-fromSingleFetch-yes");
        stableDatas = datas;
        print("sdjkasjdabajb-afterdata-${stableDatas}");
      } else {
        stableDatas ??= [];
        if (stableDatas!.last.open != datas!.first.open) {
          stableDatas!.add(datas!.first);
          nextDataIsNew = false;
        } else {
          stableDatas!.last.close = datas!.first.close;
          stableDatas!.last.vol = datas!.first.vol;
        }
        if ((list.first as Map)["confirm"]) {
          nextDataIsNew = true;
        }
      }
    } catch (e) {}

    print("debug_print_linechart-solveChatData-datas_is=$datas");

    DataUtil.calculate(datas!);
    showLoading = false;
    setState(() {});
  }

  bool nextDataIsNew = false;
  @override
  void dispose() {
    context.read<WebSocketBloc>().add(WebSocketDisconnectEvent());
    super.dispose();
  }

  KLineEntity getKLineEntityFromMap(Map item) {
    return KLineEntity.fromJson(KLineCorrectorEntity.fromJson(item).toMap());
  }
}

class KLineCorrectorEntity {
  final double open;
  final double high;
  final double low;
  final double close;
  final double amount;
  final double vol;
  final int? time;

  final double ratio;
  final double change;

  KLineCorrectorEntity({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.amount,
    required this.vol,
    required this.time,
    required this.ratio,
    required this.change,
  });

  factory KLineCorrectorEntity.fromJson(Map json) {
    final double openLet = double.tryParse(json['open'] ?? "")?.toDouble() ?? 0;
    final double highLet = double.tryParse(json['high'] ?? "")?.toDouble() ?? 0;
    final double lowLet = double.tryParse(json['low'] ?? "")?.toDouble() ?? 0;
    final double closeLet =
        double.tryParse(json['close'] ?? "")?.toDouble() ?? 0;
    final double volLet =
        double.tryParse(json['volume'] ?? "")?.toDouble() ?? 0;
    final double amountLet =
        double.tryParse(json['turnover'] ?? "")?.toDouble() ?? 0;
    int? tempTime = double.tryParse(json['time'] ?? "")?.toInt();
    //兼容火币数据
    if (tempTime == null) {
      try {
        tempTime = json['timestamp']?.toInt() ?? 0;
      } catch (e) {
        tempTime = double.tryParse(json['timestamp'] ?? '')?.toInt() ?? 0;
      }
      tempTime = tempTime! * 1000;
    }

    final int? timeLet = tempTime;
    final double ratioLet =
        double.tryParse(json['ratio'] ?? "")?.toDouble() ?? 0;
    final double changeLet =
        double.tryParse(json['change'] ?? "")?.toDouble() ?? 0;
    return KLineCorrectorEntity(
      open: openLet,
      high: highLet,
      low: lowLet,
      close: closeLet,
      amount: amountLet,
      vol: volLet,
      time: timeLet,
      ratio: ratioLet,
      change: changeLet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "open": open,
      "high": high,
      "low": low,
      "close": close,
      "amount": amount,
      "vol": vol,
      "time": time,
    };
  }
}
