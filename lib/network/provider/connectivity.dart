import 'package:connectivity_plus/connectivity_plus.dart' as connectivity_plus;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:nutrito/data/model/connectivity.dart';
import 'package:riverpod/riverpod.dart';

class ConnectivityManager extends StateNotifier<ConnectivityModel> {
  ConnectivityManager()
      : super(ConnectivityModel(connection: "", currentState: false));

  Future<ConnectivityModel> checkCurrentState() async {
    final List<ConnectivityResult> connectivityResult =
        await (connectivity_plus.Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return ConnectivityModel(
          currentState: true, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return ConnectivityModel(
          currentState: true, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return ConnectivityModel(
          currentState: true, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return ConnectivityModel(
          currentState: true, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityModel(
          currentState: false, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return ConnectivityModel(
          currentState: false, connection: connectivityResult.first.name);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return ConnectivityModel(
          currentState: false, connection: connectivityResult.first.name);
    }

    return ConnectivityModel(
        currentState: false, connection: connectivityResult.first.name);
  }
}

final connectivityStateProvider =
    StateNotifierProvider<ConnectivityManager, ConnectivityModel>(
  (ref) {
    return ConnectivityManager();
  },
);
