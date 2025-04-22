import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/order_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/languages.dart';

class ConfirmOrderDialog extends StatefulWidget {
  const ConfirmOrderDialog({super.key, required this.tid});
  final String tid;

  @override
  State<ConfirmOrderDialog> createState() => _ConfirmOrderDialogState();
}

class _ConfirmOrderDialogState extends State<ConfirmOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
              WalletSystemUserBalanceAndTradeCallingState>(
          listener: (context, state) {
        if (state is FollowTradeCallErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.errorMessage}"),
              backgroundColor: Colors.blue,
            ),
          );
        }

        if (state is FollowTradeCallSuccessState) {
          OrderModel orderModel = OrderModel.fromEntity(state.orderEntity);
          context.pop(orderModel);
        }
        // state;
      }, builder: (context, state) {
        return FancyContainerTwo(
          nulledAlign: true,
          child: Padding(
            padding: EdgeInsets.all(48.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/red_alert_icon.png"),
                const SizedBox(height: 20),
                FancyText(
                  "Confirm to follow order".toCurrentLanguage(),
                  weight: FontWeight.w600,
                  size: 24,
                ),
                const SizedBox(height: 20),
                FancyText(
                  "${"Order amount".toCurrentLanguage()}",
                  // (109.23)",
                  weight: FontWeight.w600,
                  textColor: Colors.white.withOpacity(.70),
                  size: 18,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FancyContainerTwo(
                        action: () {
                          context
                              .read<
                                  WalletSystemUserBalanceAndTradeCallingBloc>()
                              .add(FollowTradeCallEvent(widget.tid));
                          // try {
                          //   context.pop();
                          // } catch (e) {}
                        },
                        height: 45.h,
                        hasBorder: true,
                        borderColor: Colors.grey,
                        child: Text("Cancel".toCurrentLanguage()),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: FancyContainerTwo(
                        height: 45.h,
                        // hasBorder: true,
                        backgroundColor: ColorConstants.fancyGreen,
                        // borderColor: Colors.grey,
                        child: FancyText(
                          action: () {
                            try {
                              context
                                  .read<
                                      WalletSystemUserBalanceAndTradeCallingBloc>()
                                  .add(FollowTradeCallEvent(widget.tid));
                            } catch (e) {}
                          },
                          "Confirm".toCurrentLanguage(),
                          textColor: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

// assets/images/green_Success_icon.png
// assets/images/red_alert_icon.png
