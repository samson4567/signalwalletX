import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/router/api_route.dart';
import 'package:signalwavex/testScreen/line_chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey, // Add scaffold key
      drawer: drawerComponent(context), // Drawer
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(screenWidth),
          Expanded(
            // Ensure scrolling works properly
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenWidth * 0.04),
                  _buildFancyContainer(context),
                  SizedBox(height: screenWidth * 0.04),
                  _buildFancyChartContainer(context),
                  SizedBox(height: screenWidth * 0.04),
                  _buildFancyRecentTransaction(context),
                  SizedBox(height: screenWidth * 0.04),
                  _buildFancyRecentTopcoin(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/flower.png',
              fit: BoxFit.contain,
            ),
            SizedBox(width: screenWidth * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Mellisa',
                  style: TextStyles.smallText.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Feb 12 2022.05:22',
                  style: TextStyles.bodyText.copyWith(
                    fontSize: 10,
                    color: ColorConstants.primarydeepColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
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
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        return Drawer(
          child: Container(
            color: Colors.black, // Set the drawer background color to black
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/sign.png'),
                ListTile(
                  leading: const Icon(Icons.tag, color: Colors.white, size: 18),
                  title:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(MyAppRouteConstant.home);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tag, color: Colors.white, size: 18),
                  title: const Text('Market',
                      style: TextStyle(color: Colors.white)),
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
                  title: const Text('Assets',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(MyAppRouteConstant.assets);
                  },
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Help Center',
                    style: TextStyle(color: Color(0xFF313131)),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.tag, color: Colors.white, size: 18),
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(MyAppRouteConstant.settings);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tag, color: Colors.white, size: 18),
                  title: const Text('Support',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(MyAppRouteConstant.testScreen);
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('sam@mail.com',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Text('User ID: 1234',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          print("bbsdfjbsdbf");
                          context
                              .read<AuthBloc>()
                              .add(const LogoutEvent(token: ''));
                        },
                        child: state is LogoutLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Image.asset('assets/images/signout.png',
                                width: 24, height: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
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
      borderRadius: BorderRadius.circular(containerWidth * 0.05), // 5% of width
      border: Border.all(
        color: ColorConstants.lineborder,
        width: containerWidth * 0.005,
      ),
      padding: EdgeInsets.all(containerWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalAssetsSection(containerWidth),
          SizedBox(height: containerWidth * 0.04),
          _buildPnLSection(containerWidth),
          SizedBox(height: containerWidth * 0.2),
          _buildIconRow(containerWidth),
        ],
      ),
    );
  }

  Widget _buildFancyChartContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101112),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey, // Replace with your actual border color
          width: 2,
        ),
      ),
      width: 400,
      height: 435,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bitcoin USD (BTC - USD)",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "+ 231.43 (1.02%)",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green, // Replace with your color constant
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 125,
                height: 37.5,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  border: Border.all(
                      color: Colors.grey), // Replace with your color constant
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "24 Hours",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "\$97,3120",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: LineChart(), // Call the function to create chart data
          ),
        ],
      ),
    );
  }

  Widget _buildFancyRecentTransaction(BuildContext context) {
    final List<Map<String, String>> transactions = [
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'amount': '+4132.01DOGE',
        'action': 'Buy',
        'time': '9:20 AM'
      },
      {
        'icon': 'assets/icons/ton.png',
        'name': 'TON',
        'amount': '+4132.01TON',
        'action': 'Buy',
        'time': '10:45 AM'
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'ETH',
        'amount': '+4132.01ETH',
        'action': 'Buy',
        'time': '11:30 AM'
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'XRP',
        'amount': '+4132.01XRP',
        'action': 'Buy',
        'time': '12:15 PM'
      },
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'amount': '+4132.01DOGE',
        'action': 'Buy',
        'time': '1:05 PM'
      },
    ];

    return FancyContainer(
      color: const Color(0xFF101112),
      width: 400,
      height: 435,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ColorConstants.lineborder,
        width: 2,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transaction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        transaction['icon']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['name']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Buy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction['amount']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorConstants.numyelcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transaction['time']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFancyRecentTopcoin(BuildContext context) {
    final List<Map<String, String>> coins = [
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Bitcoin',
        'price': '\$96,345.6',
        'percentage': '0.83%',
      },
      {
        'icon': 'assets/icons/xrp.png',
        'name': 'Ethereum',
        'price': '\$6,345.2',
        'percentage': '1.12%',
      },
      {
        'icon': 'assets/icons/doge.png',
        'name': 'DOGE',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/sol.png',
        'name': 'SOL',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/bch.png',
        'name': 'BCH',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/lit.png',
        'name': 'LIT',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
      {
        'icon': 'assets/icons/bitcoin.png',
        'name': 'BITCOIN',
        'price': '\$0342.24',
        'percentage': '2.67%',
      },
    ];

    return FancyContainer(
      color: const Color(0xFF101112),
      width: 400,
      height: 435,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ColorConstants.lineborder,
        width: 2,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top performing coins', style: TextStyles.normaltext.copyWith()),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: coins.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFF313131),
                thickness: 1,
                height: 16,
              ),
              itemBuilder: (context, index) {
                final coin = coins[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      coin['icon']!,
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin['name']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coin['price']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          coin['percentage']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAssetsSection(double screenWidth) {
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
                    fontSize: 20, // Font size 4.5% of screen width
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // 2% spacing
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                  size: screenWidth * 0.06, // Icon size 6% of screen width
                ),
              ],
            ),
            Text(
              '\$3,256.00',
              style: TextStyles.smallText.copyWith(
                fontSize: screenWidth * 0.08, // Font size 8% of screen width
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
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
        Text(
          '+\$132',
          style: TextStyles.smallText.copyWith(
            fontSize: screenWidth * 0.045, // Font size 4.5% of screen width
            color: ColorConstants.numyelcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIconRow(double screenWidth) {
    final List<Map<String, dynamic>> iconsData = [
      {
        'imagePath': 'assets/icons/double.png',
        'label': 'Trade',
        'action': () {
          context.push(MyAppRouteConstant.trade);
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
        width: 75, // Fixed width
        height: 68, // Fixed height
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
}
