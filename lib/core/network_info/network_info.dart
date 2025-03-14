import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityHelper {
  static Future<bool> hasInternetConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}