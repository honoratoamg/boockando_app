import 'package:connectivity/connectivity.dart';

class InternetConnectionChecker {
  static Future<bool> checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}


// bool connectedUser;
// await InternetConnectionChecker.checkConnection()
// .then((value) => connectedUser = value);