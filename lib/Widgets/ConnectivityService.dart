import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  Function(ConnectivityResult)? onConnectivityChanged;

  void initialize() {
    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (onConnectivityChanged != null) {
        onConnectivityChanged!(result);
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
