import 'package:flutter/foundation.dart';
import 'package:network_notifier/constants.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService with ChangeNotifier {
  ConnectivityStatus connectivityStatus;
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityStatus = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
