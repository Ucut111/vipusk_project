import 'package:flutter/material.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';
import '../Product.dart';
import '../getting_list_interactor.dart';

class TopListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder(
        future: _loadListBeer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _beerWidget(snapshot.data);
          } else if (snapshot.hasError) {
            print('Error');
          }
          return Container();
        },
      ),
    );
  }

  Future<List<Beer>> _loadListBeer() async =>
      await GettingBeerListInteractor().execute();

  Widget _beerWidget(List<Beer> beer) => Container(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemScreen(beer: beer[index]))),
                  child: _singleBeer(beer[index]));
            },
            itemCount: beer.length,
            shrinkWrap: true),
      );

  Widget _singleBeer(Beer beer) => Container(
        width: 150,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 4), blurRadius: 3, color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.cyan.withOpacity(0.8),
        ),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Text('${beer.name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Image(
                          image: NetworkImage(beer.image_url),
                        ))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.money),
                            Text('${beer.id}'),
                          ]),
                      IconButton(icon: Icon(Icons.favorite), onPressed: null)
                    ]),
              ]),
        ),
      );
}
