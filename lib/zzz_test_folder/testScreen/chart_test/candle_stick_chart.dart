import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:signalwavex/component/fansycontainer.dart';

class CandleStickChart extends StatefulWidget {
  const CandleStickChart({super.key, this.title, this.coinSymbol, this.period});

  final String? title;
  final String? coinSymbol;
  final String? period;

  @override
  // ignore: library_private_types_in_public_api
  _CandleStickChartState createState() => _CandleStickChartState();
}

class _CandleStickChartState extends State<CandleStickChart> {
  List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.NONE;
  bool _volHidden = true;
  SecondaryState _secondaryState = SecondaryState.NONE;
  bool isLine = true;
  bool isChinese = true;
  bool _hideGrid = false;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = false;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.left;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    toReget = true;
    super.initState();
    // getData('1day');
    dataRegeter();
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      final tick = parseJson['tick'] as Map<String, dynamic>;
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
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    for (var item in bids.reversed) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    }

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    for (var item in asks) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    }
    if (mounted) setState(() {});
  }

  bool toReget = false;
  dataRegeter() async {
    await getData(null).then((value) {
      if (toReget) {
        Future.delayed(
          2.seconds,
          () {
            try {
              dataRegeter();
              if (mounted) setState(() {});
            } catch (e) {}
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        FancyContainer(
          borderRadius: BorderRadius.circular(10),
          height: 450,
          width: double.infinity,
          // width: 450,
          color: Colors.black,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: KChartWidget(
              datas,
              chartStyle,
              chartColors,
              isLine: false,
              // isLine: isLine,

              onSecondaryTap: () {
                print('Secondary Tap');
              },
              isTrendLine: _isTrendLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              translations: kChartTranslations,
              showNowPrice: _showNowPrice,
              //`isChinese` is Deprecated, Use `translations` instead.
              // isChinese: isChinese,
              hideGrid: false,
              isTapShowInfoDialog: false,
              verticalTextAlignment: _verticalTextAlignment,
              maDayList: const [1, 100, 1000],
            ),
          ),
        ),
        if (showLoading)
          Container(
              width: double.infinity,
              height: 450,
              alignment: Alignment.center,
              child: const CircularProgressIndicator()),
      ]),
    );
    // ListView(
    //   shrinkWrap: true,
    //   children: <Widget>[

    //     // buildButtons(),
    //     // if (_bids != null && _asks != null)
    //     //   Container(
    //     //     height: 230,
    //     //     width: double.infinity,
    //     //     child: DepthChart(_bids!, _asks!, chartColors),
    //     //   )
    //   ],
    // );
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
          if (mounted) setState(() {});
        }
      },
      style: TextButton.styleFrom(
        // primary: Colors.white,
        minimumSize: const Size(88, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.blue,
      ),
      child: Text(text),
    );
  }

  String? formerPeriod;
  Future getData(String? period) async {
    /*
     * 可以翻墙使用方法1加载数据，不可以翻墙使用方法2加载数据，默认使用方法1加载最新数据
     */
    final Future<String> future = getChatDataFromInternet(period);
    //final Future<String> future = getChatDataFromJson();
    await future.then((String result) {
      solveChatData(result);
    }).catchError((_) {
      showLoading = false;
      if (mounted) setState(() {});
    });
  }

  //获取火币数据，需要翻墙
  Future<String> getChatDataFromInternet(String? period) async {
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1min'}&size=300&symbol=${widget.coinSymbol?.toLowerCase() ?? "btc"}usdt';
    // https: //api.huobi.br.com/market/history/kline?period=1min&size=300&symbol=btcusdt'
    late String result;
    final response = await http.get(Uri.parse(url));
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

  solveChatData(String result) {
    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    final list = parseJson['data'] as List<dynamic>;

    datas = list
        .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();
    DataUtil.calculate(datas!);
    showLoading = false;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    toReget = false;
    super.dispose();
  }
}
