import 'package:flutter/material.dart';
import 'package:signalwavex/component/color.dart';

SnackBar generalSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: ColorConstants.fancyGreen,
  );
}

SnackBar generalErrorSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red[900],
  );
}

SnackBar generalSuccessSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green[900],
  );
}
