import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';

import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
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
              context.go(MyAppRouteConstant.settings);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag, color: Colors.white, size: 18),
            title: const Text('support', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(MyAppRouteConstant.settings);
            },
          ),
          BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            return InkWell(
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
                  Column(
                    children: [
                      Text(
                        '${state.user!.email}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        '${state.user!.id}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print("bbsdfjbsdbf");
                      context
                          .read<AuthBloc>()
                          .add(const LogoutEvent(token: ''));
                    },
                    child: Image.asset(
                      'assets/images/signout.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ),
  ));
}
