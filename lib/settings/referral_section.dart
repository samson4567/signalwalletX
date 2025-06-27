import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_event.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_state.dart';
import 'package:signalwavex/languages.dart';

class ReferralSection extends StatefulWidget {
  const ReferralSection({super.key});

  @override
  State<ReferralSection> createState() => _ReferralSectionState();
}

class _ReferralSectionState extends State<ReferralSection> {
  @override
  void initState() {
    context.read<UserBloc>().add(const GetRefferalListEvent());
    context.read<UserBloc>().add(const GetRefferalCodeEvent());

    super.initState();
  }

  ReferralCodeResponseEntity? referralCodeResponseEntity;
  ReferralListsResponseEntity? referralListsResponseEntity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(buildWhen: (previous, current) {
      return (current is GetRefferalListSuccessState ||
          current is GetRefferalListLoadingState ||
          current is GetRefferalListErrorState ||
          current is GetRefferalCodeLoadingState ||
          current is GetRefferalCodeSuccessState ||
          current is GetRefferalCodeErrorState);
    }, listener: (context, state) {
      if (state is GetRefferalListSuccessState) {
        referralListsResponseEntity = state.referralListsResponseEntity;
      }

      if (state is GetRefferalCodeSuccessState) {
        referralCodeResponseEntity = state.referralCodeResponseEntity;
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Refferals".toCurrentLanguage(),
                    style: const TextStyle(
                      fontFamily: 'inter',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (state is GetRefferalListLoadingState) {
                    return Center(
                      child: SizedBox(
                        height: 40,
                        child: const AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    );
                  }
                  if (state is GetRefferalListErrorState) {
                    return FancyText("an error occured ${state.errorMessage}");
                  }
                  return FancyText(
                      "${referralListsResponseEntity?.count ?? 0}");
                }),
              ],
            ),
          ),
          10.verticalSpace,
          Builder(builder: (context) {
            if (state is GetRefferalCodeLoadingState) {
              return Center(
                child: SizedBox(
                  height: 40,
                  child: const AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            }
            if (state is GetRefferalCodeErrorState) {
              return FancyText("an error occured ${state.errorMessage}");
            }
            if (referralCodeResponseEntity?.userIdentifier == null) {
              FancyText("No referal code for user");
            }
            return Row(
              children: [
                Expanded(
                  child: FancyText(
                      "https://www.signalwavex.com${referralCodeResponseEntity?.referralLink}"),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text:
                              "https://www.signalwavex.com${referralCodeResponseEntity?.referralLink}",
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('link Copied  to clipboard!')),
                      );
                    },
                    icon: Icon(Icons.copy_rounded))
              ],
            );
          }),
          10.verticalSpace,
          Builder(builder: (context) {
            if (state is GetRefferalListLoadingState) {
              return Center(
                child: SizedBox(
                  height: 40,
                  child: const AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            }
            if (state is GetRefferalListErrorState) {
              return FancyText("an error occured");
            }
            if (referralListsResponseEntity?.referrals?.isEmpty ?? true) {
              return Expanded(
                child: Center(
                  child: FancyText("No referals yet"),
                ),
              );
            }
            print(
                "sjdjasbdhjasdasbdj-referralListsResponseEntity_${referralListsResponseEntity}");
            return Column(
              children: [
                Row(
                  children: [
                    ...referralListsResponseEntity!.referrals!.first.keys.map(
                      (e) {
                        return (e == "id")
                            ? SizedBox(
                                width: 20,
                                child: FancyText(
                                  "${e}",
                                  size: 10,
                                ),
                              )
                            : Expanded(
                                child: FancyText(
                                  "${e}",
                                  size: 10,
                                ),
                              );
                      },
                    )
                  ],
                ),
                Divider(),
                ...referralListsResponseEntity!.referrals!.map(
                  (item) => Column(
                    children: [
                      Row(
                        children: [
                          ...item.keys.map(
                            (key) {
                              return (key == "id")
                                  ? Row(
                                      children: [
                                        (key == "id")
                                            ? SizedBox(
                                                width: 20,
                                                child: FancyText(
                                                  "${item[key]}",
                                                  size: 10,
                                                ),
                                              )
                                            : Expanded(
                                                child: FancyText(
                                                  (key == "created_at")
                                                      ? Moment(DateTime.parse(
                                                              "${item[key]}"))
                                                          .ll
                                                      : "${item[key]}",
                                                  size: 10,
                                                ),
                                              ),
                                        Container(
                                            height: 30,
                                            child: VerticalDivider())
                                      ],
                                    )
                                  : Expanded(
                                      child: Row(
                                      children: [
                                        (key == "id")
                                            ? SizedBox(
                                                width: 20,
                                                child: FancyText(
                                                  "${item[key]}",
                                                  size: 10,
                                                ),
                                              )
                                            : Expanded(
                                                child: FancyText(
                                                  (key == "created_at")
                                                      ? Moment(DateTime.parse(
                                                              "${item[key]}"))
                                                          .ll
                                                      : "${item[key]}",
                                                  size: 10,
                                                ),
                                              ),
                                        Container(
                                            height: 30,
                                            child: VerticalDivider())
                                      ],
                                    ));
                            },
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ],
            );
          }),
        ]),
      );
    });
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'inter',
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }

// Variant: debug
// Config: debug
// Store: /Users/macbookpro/.android/debug.keystore
// Alias: AndroidDebugKey
// MD5: 57:B8:E1:69:55:F3:D9:E9:07:1A:1E:C6:3E:1D:AD:F6
// SHA1: 6B:70:FC:2C:92:84:25:1C:D7:C4:2C:33:70:7A:DB:79:E3:00:43:17
// SHA-256: 74:C7:B1:41:FE:AC:15:AF:00:BF:CE:D7:55:54:56:72:34:D3:AE:B2:B1:6E:AA:DF:BE:75:E1:DA:4B:28:D7:E7
// Valid until: Monday 26 January 2054
// ----------
// Variant: release
// Config: debug
// Store: /Users/macbookpro/.android/debug.keystore
// Alias: AndroidDebugKey
// MD5: 57:B8:E1:69:55:F3:D9:E9:07:1A:1E:C6:3E:1D:AD:F6
// SHA1: 6B:70:FC:2C:92:84:25:1C:D7:C4:2C:33:70:7A:DB:79:E3:00:43:17
// SHA-256: 74:C7:B1:41:FE:AC:15:AF:00:BF:CE:D7:55:54:56:72:34:D3:AE:B2:B1:6E:AA:DF:BE:75:E1:DA:4B:28:D7:E7
// Valid until: Monday 26 January 2054
}
