import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/beer_pattern_bloc.dart';
import 'package:vipusk_project/model/Product.dart';
import 'package:vipusk_project/InternetState.dart';

import '../widget/LodingWidget.dart';
import '../repository.dart';
import 'CartScreen.dart';

class ItemScreen extends StatelessWidget {
  final Beer beer;
  final _bloc = BeersPatternBloc(Repository());
  ItemScreen({@required this.beer});
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
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  }),
            )
          ],
        ),
        body: StreamBuilder(
          stream: _bloc.internetState,
          initialData: InternetState.connected,
          builder: (context, snapshot) {
            InternetState state = snapshot.data;
            switch (state) {
              case InternetState.connected:
                {
                  return BodyItemScreen(
                    beer: beer,
                  );
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
}

class BodyItemScreen extends StatelessWidget {
  final Beer beer;
  BodyItemScreen({@required this.beer});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://p1.zoon.ru/9/4/5a3bc7b6a24fd9259f42127a_5ab8e1b6dcb96.jpg'),
          fit: BoxFit.cover,
        )),
        child: Container(
          decoration: BoxDecoration(color: Colors.blue[100].withOpacity(0.7)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                child: Image.network(
                  beer.imageUrl,
                  scale: 3,
                ),
              )),
              Text('${beer.tagline}'),
            ],
          ),
        ));
  }
}
