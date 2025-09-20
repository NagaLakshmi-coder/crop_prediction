import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends ChangeNotifier {
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  ConnectivityService() {
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // If any of the results is not none, we are online
      _isOnline = results.any((result) => result != ConnectivityResult.none);
      notifyListeners();
    });
  }

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _isOnline = result != ConnectivityResult.none;
    notifyListeners();
  }
}
