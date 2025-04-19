// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_state.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey, // Add scaffold key
      drawer: drawerComponent(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      context.push(MyAppRouteConstant.home);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState
                          ?.openDrawer(); // Open drawer correctly
                    },
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildFancyContainer(context),
              SizedBox(height: screenWidth * 0.04),
              SizedBox(height: screenWidth * 0.04),
              SizedBox(height: screenWidth * 0.04),
              _buildAccountSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFancyContainer(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth = screenWidth * 0.9;
    containerWidth = containerWidth > 400 ? 400 : containerWidth;

    double containerHeight = containerWidth * 0.805;

    return FancyContainer(
      color: const Color(0xFF101112),
      width: containerWidth,
      height: containerHeight,
      borderRadius: BorderRadius.circular(containerWidth * 0.05),
      border: Border.all(
        color: ColorConstants.primaryGrayColor,
        width: containerWidth * 0.005,
      ),
      padding: EdgeInsets.all(containerWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalAssetsSection(containerWidth, context),
          SizedBox(height: containerWidth * 0.04),
          _buildPnLSection(containerWidth),
          SizedBox(height: containerWidth * 0.1),
          _buildIconRow(containerWidth),
        ],
      ),
    );
  }

  Widget _buildTotalAssetsSection(double screenWidth, BuildContext context) {
    final walletBloc =
        BlocProvider.of<WalletSystemUserBalanceAndTradeCallingBloc>(context);

    // Track the visibility state of the balance
    bool isBalanceVisible = true;

    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is FetchAllAccountBalanceErrorState) {
          // Handle the error state
        }
      },
      builder: (context, state) {
        double totalBalance = 0;

        if (state is FetchAllAccountBalanceSuccessState) {
          totalBalance = state.listOfWalletsBalances.fold(0, (sum, wallet) {
            final balance = double.tryParse(wallet.actualQuantity ?? '0') ?? 0;
            return sum + balance;
          });
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Assets'.toCurrentLanguage(),
                      style: TextStyles.title.copyWith(
                        fontSize: screenWidth * 0.045, // 4.5% of screen width
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    IconButton(
                      icon: Icon(
                        isBalanceVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons
                                .remove_red_eye, // Change icon based on visibility state
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () {
                        isBalanceVisible = !isBalanceVisible;

                        walletBloc.add(const FetchAllAccountBalanceEvent());
                      },
                    ),
                  ],
                ),
                Text(
                  isBalanceVisible
                      ? '\$${totalBalance.toStringAsFixed(2)}' // Shows 0.00 if balance is 0
                      : '*****',
                  style: TextStyles.smallText.copyWith(
                    fontSize: screenWidth * 0.08,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPnLSection(double screenWidth) {
    return Row(
      children: [
        Text(
          'Today\'s PnL:'.toCurrentLanguage(),
          style: TextStyles.subtitle.copyWith(
            fontSize: screenWidth * 0.045, // Font size 4.5% of screen width
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: screenWidth * 0.01), // 1% spacing
        BlocConsumer<AppBloc, AppState>(
            listener: (BuildContext context, AppState state) {
          if (state is StorePNLSuccessState) {}
        }, builder: (context, state) {
          return Text(
            '+\$${state.pnl?.substring(0, 4) ?? 0}',
            style: TextStyles.smallText.copyWith(
              fontSize: screenWidth * 0.045, // Font size 4.5% of screen width
              color: ColorConstants.numyelcolor,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildIconRow(double screenWidth) {
    final List<Map<String, dynamic>> iconsData = [
      {
        'imagePath': 'assets/icons/double.png',
        'label': 'Withdraw',
        'action': () {
          context.push(MyAppRouteConstant.withdraw);
        }
      },
      {
        'imagePath': 'assets/icons/Refresh.png',
        'label': 'Convert',
        'action': () {
          context.push(MyAppRouteConstant.convert);
        }
      },
      {
        'imagePath': 'assets/icons/arrowdown.png',
        'label': 'Deposit',
        'action': () {
          context.push(MyAppRouteConstant.deposit);
        }
      },
      {
        'imagePath': 'assets/icons/dang.png',
        'label': 'Transfer',
        'action': () {
          context.push(MyAppRouteConstant.transfer);
        }
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: iconsData.asMap().entries.map((entry) {
        final index = entry.key;
        final icon = entry.value;
        return _buildIconItem(
          imagePath: icon['imagePath']!,
          label: icon['label']!,
          screenWidth: screenWidth,
          isSelected: _selectedIndex == index,
          onTap: () {
            icon['action']?.call();
            setState(() {
              _selectedIndex = index;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildIconItem({
    required String imagePath,
    required String label,
    required double screenWidth,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: FancyContainer(
        width: 75,
        height: 68,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: isSelected
              ? const Color.fromARGB(255, 28, 23, 192)
              : ColorConstants.primarydeepColor,
        ),
        color: isSelected ? ColorConstants.blueSelectionColor : Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: screenWidth * 0.1, // 10% of screen width
                  height: screenWidth * 0.1,
                ),
                SizedBox(height: screenWidth * 0.01), // 1% spacing
                Text(
                  label,
                  style: TextStyles.caption.copyWith(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account'.toCurrentLanguage(),
          style: TextStyles.title.copyWith(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 10),
        _buildAccountContainer('Exchange'.toCurrentLanguage(), '\$0.000'),
        const SizedBox(height: 10),
        _buildAccountContainer('Trade'.toCurrentLanguage(), '\$3,200'),
        const SizedBox(height: 10),
        // _buildAccountContainer('Perpetual'.toCurrentLanguage(), '\$0.000'),
      ],
    );
  }

  Widget _buildAccountContainer(String title, String value) {
    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is FetchAllAccountBalanceErrorState) {}
      },
      builder: (context, state) {
        double totalBalance = 0;

        if (state is FetchAllAccountBalanceSuccessState) {
          totalBalance = state.listOfWalletsBalances.fold(0, (sum, wallet) {
            final balance = double.tryParse(wallet.actualQuantity ?? '0') ?? 0;
            return sum + balance;
          });
        }
        String displayedValue = value; // Default value
        if (title == 'Trade'.toCurrentLanguage()) {
          displayedValue = '\$${totalBalance.toStringAsFixed(2)}';
        }
        return FancyContainer(
          width: 400,
          height: 103,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.primaryGrayColor, width: 2),
          color: const Color(0xFF101112),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.bodyText.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                displayedValue,
                style: TextStyles.smallText.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
