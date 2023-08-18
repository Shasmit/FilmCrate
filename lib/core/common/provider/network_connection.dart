import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectivity() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
