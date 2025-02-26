import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';

class ShimmerUiHandler {
  // Widget getUI() {
  //   return SizedBox();
  // }
  Widget getQuadilateralShimer({
    double? height,
    double? width,
    double? radius,
  }) {
    Widget child = FancyContainerTwo(
      padding: const EdgeInsets.all(16),
      hasBorder: true,
      borderColor: Colors.red,
      backgroundColor: Colors.red,
      borderThickness: 3,
      radius: radius,
      height: height,
      width: width,
    );

    return
        // child;
        shimmerize(child);
  }

  Widget shimmerize(
    Widget child, {
    Color? baseColor,
    Color? highlightColor,
    ShimmerDirection? shimmerDirection,
  }) {
    shimmerDirection ??= ShimmerDirection.ltr;
    highlightColor ??= ColorConstants.fancyGreen.withAlpha(10);
    baseColor ??= ColorConstants.backgroundColor;
    return Shimmer.fromColors(
        direction: shimmerDirection,
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: child
        // .withAlpha(10)
        );
  }
}
