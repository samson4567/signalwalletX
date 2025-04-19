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
          context.go(MyAppRouteConstant.login);
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
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Image.asset('assets/images/sign.png'),
            _buildListTile(
                context, Icons.home, 'Home', MyAppRouteConstant.home),
            _buildListTile(
                context, Icons.store, 'Market', MyAppRouteConstant.market),
            // _buildListTile(context, Icons.sync_alt, 'Perpetual',
            //     MyAppRouteConstant.perpetual),
            _buildListTile(context, Icons.account_balance_wallet, 'Assets',
                MyAppRouteConstant.assets),
            const SizedBox(height: 220),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Help Center',
                  style: TextStyle(color: Color(0xFF313131))),
            ),
            _buildListTile(context, Icons.settings, 'Settings',
                MyAppRouteConstant.settings),
            _buildListTile(
                context, Icons.support, 'Support', MyAppRouteConstant.settings),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state.user == null) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Not logged in',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user?.email ?? 'No email',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              '${state.user?.id ?? 'No ID'}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(const LogoutEvent(token: ''));
                          },
                          child: Image.asset(
                            'assets/images/signout.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper function for creating list tiles
Widget _buildListTile(
    BuildContext context, IconData icon, String title, String route) {
  return ListTile(
    leading: Icon(icon, color: Colors.white, size: 18),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    onTap: () {
      Navigator.pop(context);
      context.go(route);
    },
  );
}
