import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';

class OrderFollowedDialog extends StatefulWidget {
  const OrderFollowedDialog({super.key});

  @override
  State<OrderFollowedDialog> createState() => _OrderFollowedDialogState();
}

class _OrderFollowedDialogState extends State<OrderFollowedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FancyContainerTwo(
        nulledAlign: true,
        child: Padding(
          padding: EdgeInsets.all(48.0.h.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/green_Success_icon.png"),
              SizedBox(height: 20),
              FancyText(
                "Order Followed",
                weight: FontWeight.w600,
                size: 24,
              ),
              SizedBox(height: 20),
              FancyText(
                "The trade order has been successfully followed.",
                weight: FontWeight.w600,
                textColor: Colors.white.withOpacity(.70),
                size: 18,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FancyContainerTwo(
                      action: () {
                        try {
                          context.pop();
                        } catch (e) {}
                      },
                      height: 45.h,
                      // hasBorder: true,
                      backgroundColor: ColorConstants.fancyGreen,
                      // borderColor: Colors.grey,
                      child: FancyText(
                        "Okay",
                        textColor: Colors.black,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// assets/images/green_Success_icon.png
// assets/images/red_alert_icon.png
