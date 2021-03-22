import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/beer_pattern_bloc.dart';
import 'package:vipusk_project/repository.dart';
import 'package:vipusk_project/widget/LodingWidget.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/InternetState.dart';

class BottomListView extends StatefulWidget {
  @override
  _BottomListViewState createState() => _BottomListViewState();
}

final _bloc = BeersPatternBloc(Repository());

class _BottomListViewState extends State<BottomListView> {
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
      padding: const EdgeInsets.all(10),
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
          }),
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
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => bloc.tapOnItem.add(snapshot.data[index]),
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
      margin: const EdgeInsets.all(8),
      height: 150,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: const AssetImage('assets/1.jpg'), fit: BoxFit.cover),
        boxShadow: [
          const BoxShadow(
            offset: const Offset(1, 4),
            blurRadius: 3,
            color: Colors.black12,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Image(
                  image: NetworkImage(beer.imageUrl),
                ))),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text('${beer.name}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {},
                        )
                      ]),
                  Text(
                    '${beer.tagline}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(children: [const Icon(Icons.money), Text('${beer.id}')]),
                ]),
          ),
        )
      ]),
    );
  }
}
