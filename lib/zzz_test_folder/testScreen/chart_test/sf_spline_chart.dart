/// Package import.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/chart_test/sample_view.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local import.

/// Renders the default Spline Chart sample.
class SplineDefault extends SampleView {
  const SplineDefault(Key? key) : super(key: key);

  @override
  _SplineDefaultState createState() => _SplineDefaultState();
}

/// State class of the default Spline Chart.
class _SplineDefaultState extends SampleViewState {
  _SplineDefaultState();
  Map rawData = {};
  Map processedData = {};

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 13),
      ChartData(2012, 34),
      ChartData(2013, 27),
      ChartData(2014, 40),
    ];
    return Scaffold(
        body: BlocConsumer<WebSocketBloc, WebSocketState>(
            listener: (context, state) {
      if (state is WebSocketDataState) {
        rawData = jsonDecode(state.data);
      }
    }, builder: (context, state) {
      return Center(
          child: Container(
              child: SfCartesianChart(series: <CartesianSeries>[
        // Renders spline chart
        SplineSeries<ChartData, int>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ])));
    }));
  }

  // fre
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
