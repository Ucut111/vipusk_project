import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/NoInternetPage_bloc.dart';

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
          TextNoInternet(),
          _rowUpdate(),
        ],
      ),
    );
  }

  Widget _rowUpdate() {
    return ElevatedButton(
      onPressed: _bloc.onUpdateTap,
      child: const Text("Обновить страницу"),
    );
  }
}

class TextNoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: const Text("Подключение к интернету отсутствует",
          textAlign: TextAlign.center),
    ));
  }
}
