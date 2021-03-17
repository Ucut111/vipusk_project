import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/getRandom_bloc.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/widget/LodingWidget.dart';

import '../InternetState.dart';
import '../repository.dart';

class RandomScreen extends StatelessWidget {
  final _bloc = RandomBeersPatternBloc(RepositoryRandom());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0,
          leading: IconButton(
            icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Icon(Icons.arrow_back)),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: StreamBuilder(
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
                  return LoadingPage();
                }
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _beersWidget() => StreamBuilder(
        stream: _bloc.internetState,
        initialData: InternetState.connected,
        builder: (context, snapshot) {
          InternetState state = snapshot.data;
          switch (state) {
            case InternetState.connected:
              {
                _bloc.getBeers();
                return _getbeersWidget();
              }
            case InternetState.notConnected:
              {
                return LoadingPage();
              }
          }
          return Container();
        },
      );

  Widget _getbeersWidget() => StreamBuilder(
      stream: _bloc.streamBeers,
      builder: (context, snapshot) => _bodyItemScreen(snapshot.data));

  Widget _bodyItemScreen(Beer beer) => Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://p1.zoon.ru/9/4/5a3bc7b6a24fd9259f42127a_5ab8e1b6dcb96.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue[100].withOpacity(0.7)),
        child: Center(
            child: Column(
          children: [
            Expanded(
                child: Container(
              child: Container(
                child: Image.network(
                  beer.image_url,
                  scale: 3,
                ),
              ),
            )),
            Text('${beer.tagline}'),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 4,
            // )
          ],
        )),
      ));
}
