import 'dart:async';

import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/repository.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';

import '../InternetState.dart';

class BeersPatternBloc {
  List<Beer> _listItems;
  Repository _repository;

  final _outInternetStateStream = StreamController<InternetState>.broadcast();
  final _outNavigateTo = StreamController.broadcast();
  final _outGetBeers = StreamController.broadcast();
  final _inTapOnItem = StreamController<Beer>.broadcast();
  final _inHaveInternet = StreamController<InternetState>.broadcast();

  Stream get internetState => _outInternetStateStream.stream;
  Stream get navigateTo => _outNavigateTo.stream;
  Stream get streamBeers => _outGetBeers.stream;
  StreamSink get tapOnItem => _inTapOnItem.sink;
  StreamSink get haveInternet => _inHaveInternet.sink;

  BeersPatternBloc(this._repository) {
    _inTapOnItem.stream.listen(_tapOnItem);
    _inHaveInternet.stream
        .listen((state) => _changeInternetAction(InternetState.connected));
  }

  Future<void> getBeers() async {
    _listItems = await _repository.loadListBeers();
    if (_listItems != null) {
      _outGetBeers.sink.add(_listItems);
    } else {
      return _changeInternetAction(InternetState.notConnected);
    }
  }

  getBeersLenght() {
    return _listItems.length;
  }

  void _changeInternetAction(data) {
    _outInternetStateStream.sink.add(data);
  }

  void _tapOnItem(Beer beer) {
    _outNavigateTo.sink.add(ItemScreen(beer: beer));
  }

  void dispose() {
    _outInternetStateStream.close();
    _outNavigateTo.close();
    _outGetBeers.close();
    _inTapOnItem.close();
    _inHaveInternet.close();
  }
}
