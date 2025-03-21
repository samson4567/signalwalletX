import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/back_button.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fancy_text.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';
import 'package:signalwavex/router/api_route.dart';

Drawer drawerComponent(BuildContext context) {
  return Drawer(
      child: BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is LogoutSuccessState) {
        context.go(MyAppRouteConstant.signupscreen);
      } else if (state is LogoutErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    child: Container(
      color: Colors.black, // Set the drawer background color to black
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Image.asset('assets/images/sign.png'),
          ListTile(
            leading:
                const Icon(Icons.tag, color: Colors.white, size: 18), // # icon
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(MyAppRouteConstant.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag, color: Colors.white, size: 18),
            title: const Text('Market', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(MyAppRouteConstant.market);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag, color: Colors.white, size: 18),
            title:
                const Text('Perpetual', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(MyAppRouteConstant.perpetual);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag, color: Colors.white, size: 18),
            title: const Text('Assets', style: TextStyle(color: Colors.white)),
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
            title: const Text('support', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(MyAppRouteConstant.assets);
            },
          ),
          InkWell(
            onTap: () {
              print("dsnbfjkbdfbsfbsdkjfb");
            },
            child: Row(
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
                InkWell(
                  onTap: () {
                    print("bbsdfjbsdbf");
                    context.read<AuthBloc>().add(const LogoutEvent(token: ''));
                  },
                  child: Image.asset(
                    'assets/images/signout.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}



// class DrawerComponent extends StatefulWidget {
//   const DrawerComponent({super.key});

//   @override
//   State<DrawerComponent> createState() => _DrawerComponentState();
// }

// class _DrawerComponentState extends State<DrawerComponent> {
//   @override
//   Widget build(BuildContext context) {
//     return _buildDrawer(context);
//   }

//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Colors.black, // Set the drawer background color to black
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             Image.asset('assets/images/sign.png'),
//             ListTile(
//               leading: const Icon(Icons.tag,
//                   color: Colors.white, size: 18), // # icon
//               title: const Text('Home', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.home);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.tag, color: Colors.white, size: 18),
//               title:
//                   const Text('Market', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.market);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.tag, color: Colors.white, size: 18),
//               title: const Text('Perpetual',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.perpetual);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.tag, color: Colors.white, size: 18),
//               title:
//                   const Text('Assets', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.assets);
//               },
//             ),
//             const SizedBox(
//               height: 220,
//             ),
//             const Text(
//               'Help Center',
//               style: TextStyle(color: Color(0xFF313131)),
//             ),
//             ListTile(
//               leading: const Icon(Icons.tag, color: Colors.white, size: 18),
//               title:
//                   const Text('settings', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.assets);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.tag, color: Colors.white, size: 18),
//               title:
//                   const Text('support', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go(MyAppRouteConstant.assets);
//               },
//             ),
//             InkWell(
//               onTap: () {
//                 print("dsnbfjkbdfbsfbsdkjfb");
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage('assets/images/profile.png'),
//                   ),
//                   const Column(
//                     children: [
//                       Text(
//                         'sam@mail.con',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       Text(
//                         'sam@mail.con',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () {
//                       print("bbsdfjbsdbf");
//                       context
//                           .read<AuthBloc>()
//                           .add(const LogoutEvent(token: ''));
//                     },
//                     child: Image.asset(
//                       'assets/images/signout.png',
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Material _stupidMove() {
//     return Material(
//       child: FancyContainerTwo(
//         backgroundColor: Colors.white.withAlpha(20),
//         borderRadius: const BorderRadius.horizontal(right: Radius.circular(40)),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/sign.png',
//                   fit: BoxFit.contain,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             FancyContainerTwo(
//               backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Home"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 5),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Markets"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 5),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Futures"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 5),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Perpetual"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 5),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Assets"),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 FancyText(
//                   " Help Center",
//                   textColor: getFigmaColor("98A2B3"),
//                 ),
//               ],
//             ),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Settings"),
//                 ],
//               ),
//             ),
//             FancyContainerTwo(
//               // backgroundColor: getFigmaColor("1D2739"),
//               action: () {
//                 // context.go(location);
//               },
//               height: 44,
//               child: Row(
//                 children: [
//                   FancyText(
//                     " # ",
//                     weight: FontWeight.w800,
//                   ),
//                   const Text("Support"),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildUserImageStack(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FancyText(
//                       "Melissa",
//                       weight: FontWeight.w800,
//                     ),
//                     FancyText(
//                       "melissa@gmail.com",
//                       weight: FontWeight.w800,
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.logout_rounded,
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   SizedBox _buildUserImageStack() {
//     return SizedBox(
//       height: 30,
//       width: 30,
//       child: Stack(
//         children: [
//           FancyContainerTwo(
//             height: double.infinity,
//             width: double.infinity,
//             radius: 40,
//             backgroundColor: Colors.blue,
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: FancyContainerTwo(
//               height: 10,
//               width: 10,
//               radius: 40,
//               hasBorder: true,
//               borderColor: Colors.white,
//               backgroundColor: getFigmaColor("04802E"),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
