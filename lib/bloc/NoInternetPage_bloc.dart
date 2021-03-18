import 'package:connectivity/connectivity.dart';

class NoInternetPageBloc {
  final Function() hasInternet;

  NoInternetPageBloc({this.hasInternet});

  Future<void> _checkConnection() async {
    var state = await Connectivity().checkConnectivity();
    while (state == ConnectivityResult.none) {
      await Future.delayed(Duration(milliseconds: 100));
      state = await Connectivity().checkConnectivity();
    }
    hasInternet();
  }

  Future<void> onUpdateTap() async {
    await _checkConnection();
  }
}
