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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Set the drawer background color to black
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Image.asset('assets/images/sign.png'),
            ListTile(
              leading: const Icon(Icons.tag,
                  color: Colors.white, size: 18), // # icon
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tag, color: Colors.white, size: 18),
              title:
                  const Text('Market', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.market);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tag, color: Colors.white, size: 18),
              title: const Text('Perpetual',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.perpetual);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tag, color: Colors.white, size: 18),
              title:
                  const Text('Assets', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.assets);
              },
            ),
            const SizedBox(
              height: 220,
            ),
            const Text(
              'Help Center',
              style: TextStyle(color: Color(0xFF313131)),
            ),
            ListTile(
              leading: const Icon(Icons.tag, color: Colors.white, size: 18),
              title:
                  const Text('settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.assets);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tag, color: Colors.white, size: 18),
              title:
                  const Text('support', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.go(MyAppRouteConstant.assets);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const Column(
                  children: [
                    Text(
                      'sam@mail.con',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'sam@mail.con',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/signout.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ],
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

    return BlocConsumer<WalletSystemUserBalanceAndTradeCallingBloc,
        WalletSystemUserBalanceAndTradeCallingState>(
      listener: (context, state) {
        if (state is FetchAllAccountBalanceErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchAllAccountBalanceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

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
                      'Total Assets',
                      style: TextStyles.title.copyWith(
                        fontSize: screenWidth * 0.045, // 4.5% of screen width
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () {
                        // Refresh balances when the eye icon is pressed
                        walletBloc.add(const FetchAllAccountBalanceEvent());
                      },
                    ),
                  ],
                ),
                Text(
                  // Display real balance or placeholder
                  state is FetchAllAccountBalanceSuccessState
                      ? '\$${totalBalance.toStringAsFixed(2)}'
                      : 'Loading...',
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
          'Today\'s PnL:',
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
          'Account',
          style: TextStyles.title.copyWith(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'),
        ),
        const SizedBox(height: 10),
        _buildAccountContainer('Exchange', '0.000'),
        const SizedBox(height: 10),
        _buildAccountContainer('Trade', '\$3,200'),
        const SizedBox(height: 10),
        _buildAccountContainer('Exchange', '0.000'),
      ],
    );
  }

  Widget _buildAccountContainer(String title, String value) {
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
            value,
            style: TextStyles.smallText.copyWith(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'inter'),
          ),
        ],
      ),
    );
  }
}
