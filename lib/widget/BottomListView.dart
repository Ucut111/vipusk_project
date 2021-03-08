import 'package:flutter/material.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';

import '../Product.dart';
import '../getting_list_interactor.dart';

class BottomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: _loadListBeer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _beerWidget(snapshot.data);
              } else if (snapshot.hasError) {
                print('Error');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }

  Future<List<Beer>> _loadListBeer() async =>
      await GettingBeerListInteractor().execute();

  Widget _beerWidget(List<Beer> beer) => ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ItemScreen(beer: beer[index]))),
            child: _singleBeer(beer[index]));
      },
      itemCount: beer.length,
      shrinkWrap: true);

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
                            onPressed: () {},
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
