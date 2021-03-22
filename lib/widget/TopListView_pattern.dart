import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/beer_pattern_bloc.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/InternetState.dart';
import 'package:vipusk_project/repository.dart';
import 'package:vipusk_project/widget/LodingWidget.dart';

class TopListView extends StatefulWidget {
  @override
  _TopListViewState createState() => _TopListViewState();
}

final _bloc = BeersPatternBloc(Repository());

class _TopListViewState extends State<TopListView> {
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
      height: MediaQuery.of(context).size.height / 4,
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
                return BeersWidget();
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
}

class BeersWidget extends StatelessWidget {
  final bloc;
  BeersWidget({this.bloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _bloc.streamBeers,
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => _bloc.tapOnItem.add(snapshot.data[index]),
                        child: SingleBeer(beer: snapshot.data[index]));
                  },
                  itemCount: _bloc.getBeersLenght(),
                  shrinkWrap: true)
              : LoadingPage()),
    );
  }
}

class SingleBeer extends StatelessWidget {
  final Beer beer;

  SingleBeer({this.beer});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(1, 4), blurRadius: 3, color: Colors.black12)
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.cyan.withOpacity(0.8),
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Text('${beer.name}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                      margin: EdgeInsets.all(5),
                      child: Image(
                        image: NetworkImage(beer.imageUrl),
                      ))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Icon(Icons.money),
                Text('${beer.id}'),
                IconButton(icon: const Icon(Icons.favorite), onPressed: () {})
              ]),
            ]),
      ),
    );
  }
}
