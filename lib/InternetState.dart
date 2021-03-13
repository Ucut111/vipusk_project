import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

enum InternetState { connected, notConnected }

class NoInternetPage extends StatefulWidget {
  final void Function() haveInternetAction;

  NoInternetPage({@required this.haveInternetAction});

  @override
  State<StatefulWidget> createState() => NoInternetPageState();
}

class NoInternetPageState extends State<NoInternetPage> {
  NoInternetPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NoInternetPageBloc(hasInternet: widget.haveInternetAction);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textNoInternet(),
          _rowUpdate(),
        ],
      ),
    );
  }

  Widget _textNoInternet() {
    return Center(
      child: Text("Подключение к интернету отсутствует",
          textAlign: TextAlign.center),
    );
  }

  Widget _rowUpdate() {
    return RaisedButton(
      onPressed: _bloc.onUpdateTap,
      child: Text("Обновить страницу"),
    );
  }
}

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
