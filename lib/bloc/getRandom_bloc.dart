import 'dart:async';

import 'package:vipusk_project/InternetState.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/repository.dart';

class RandomBeersPatternBloc {
  List<Beer> _listItems;
  RepositoryRandom _repository;

  final _outInternetStateStream = StreamController<InternetState>.broadcast();
  final _outNavigateTo = StreamController.broadcast();
  final _outGetBeers = StreamController.broadcast();
  final _inHaveInternet = StreamController<InternetState>.broadcast();

  Stream get internetState => _outInternetStateStream.stream;
  Stream get navigateTo => _outNavigateTo.stream;
  Stream get streamBeers => _outGetBeers.stream;
  StreamSink get haveInternet => _inHaveInternet.sink;

  RandomBeersPatternBloc(this._repository) {
    _inHaveInternet.stream
        .listen((state) => _changeInternetAction(InternetState.connected));
  }

  Future<void> getBeers() async {
    _listItems = await _repository.loadListBeers();
    if (_listItems != null) {
      _outGetBeers.sink.add(_listItems.first);
    } else {
      return _changeInternetAction(InternetState.notConnected);
    }
  }

  void _changeInternetAction(data) {
    _outInternetStateStream.sink.add(data);
  }

  void dispose() {
    _outInternetStateStream.close();
    _outNavigateTo.close();
    _outGetBeers.close();
    _inHaveInternet.close();
  }
}
