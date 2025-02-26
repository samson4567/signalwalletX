import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/back_button.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';

class ConfirmOrderDialog extends StatefulWidget {
  const ConfirmOrderDialog({super.key});

  @override
  State<ConfirmOrderDialog> createState() => _ConfirmOrderDialogState();
}

class _ConfirmOrderDialogState extends State<ConfirmOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FancyContainerTwo(
        nulledAlign: true,
        child: Padding(
          padding: EdgeInsets.all(48.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/red_alert_icon.png"),
              SizedBox(height: 20),
              FancyText(
                "Confirm to follow order",
                weight: FontWeight.w600,
                size: 24,
              ),
              SizedBox(height: 20),
              FancyText(
                "Order amount (109.23)",
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
                      hasBorder: true,
                      borderColor: Colors.grey,
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FancyContainerTwo(
                      height: 45.h,
                      // hasBorder: true,
                      backgroundColor: ColorConstants.fancyGreen,
                      // borderColor: Colors.grey,
                      child: FancyText(
                        action: () {
                          try {
                            context.pop();
                          } catch (e) {}
                        },
                        "Confirm",
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
