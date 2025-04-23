import 'package:flutter/material.dart';
import 'package:signalwavex/component/fancy_container_two.dart';

Widget buildEmptyWidget(String message, [Widget? actionChild]) {
  return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
        FancyContainerTwo(
          nulledAlign: true,
          backgroundColor: Colors.grey.withAlpha(100),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete_outline,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(message),
        const SizedBox(height: 20),
        if (actionChild != null) actionChild
      ]));
}
