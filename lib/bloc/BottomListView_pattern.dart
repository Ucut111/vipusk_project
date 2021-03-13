import 'package:flutter/material.dart';
import 'package:vipusk_project/widget/LodingWidget.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/InternetState.dart';

import '../repository.dart';
import 'beer_pattern_bloc.dart';

class BottomListView extends StatefulWidget {
  @override
  _BottomListViewState createState() => _BottomListViewState();
}

class _BottomListViewState extends State<BottomListView> {
  final _bloc = BeersPatternBloc(Repository());

  @override
  void initState() {
    super.initState();
    _bloc.navigateTo.listen((page) async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => page));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(10),
      child: StreamBuilder(
        stream: _bloc.internetState,
        initialData: InternetState.connected,
        builder: (context, snapshot) {
          InternetState state = snapshot.data;
          switch (state) {
            case InternetState.connected:
              {
                _bloc.getBeers();
                return _beersWidget();
              }
            case InternetState.notConnected:
              {
                return NoInternetPage(
                    haveInternetAction: () => _bloc.haveInternet.add(null));
              }
          }
          return Container();
        },
      ),
    );
  }

  Widget _beersWidget() => StreamBuilder(
      initialData: [],
      stream: _bloc.streamBeers,
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => _bloc.tapOnItem.add(snapshot.data[index]),
                    child: _singleBeer(snapshot.data[index]));
              },
              itemCount: _bloc.getBeersLenght(), //сделать геттер длинны
              shrinkWrap: true)
          : LoadingPage());

  Widget _singleBeer(Beer beer) => Container(
        margin: EdgeInsets.all(8),
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://media.istockphoto.com/photos/beer-background-ice-cold-pint-with-water-drops-condensation-picture-id466395900'),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 4),
              blurRadius: 3,
              color: Colors.black12,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          // color: Colors.cyan.withOpacity(0.8),
        ),
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Expanded(
              flex: 1,
              child: Image(
                image: NetworkImage(beer.image_url),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text('${beer.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              //   Provider.of<FavState>(context).addBeer(
                              //     id: beer.id,
                              //     name: beer.name,
                              //     image_url: beer.image_url,
                              //     tagline: beer.tagline,
                              //   );
                            },
                          )
                        ]),
                    Text(
                      '${beer.tagline}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Text('${beer.ibu}'),
                    // Text('${beer.ph}'),
                    Row(children: [Icon(Icons.money), Text('${beer.id}')]),
                  ]),
            ),
          )
        ]),
      );
}
