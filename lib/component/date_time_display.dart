import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class LiveDateTimeWidget extends StatefulWidget {
  const LiveDateTimeWidget({super.key, this.textStyle});
  final TextStyle? textStyle;

  @override
  State<LiveDateTimeWidget> createState() => _LiveDateTimeWidgetState();
}

class _LiveDateTimeWidgetState extends State<LiveDateTimeWidget> {
  DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Update the time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd yyyy').format(_now);
    final formattedTime = DateFormat('hh:mm').format(_now);

    return Text(
      '$formattedDate • $formattedTime',

      style: widget.textStyle ??
          const TextStyle(fontSize: 16), // Adjust style as needed
    );
  }
}
