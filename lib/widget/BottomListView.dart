import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vipusk_project/Product.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';

class BottomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: loadListBeer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return beerWidget(snapshot.data);
              } else if (snapshot.hasError) {
                print('Error');
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

Future<List<Product>> loadListBeer() async =>
    await GettingBeerListInteractor().execute();

Widget beerWidget(List<Product> beer) => ListView.builder(
    itemBuilder: (context, index) {
      return _singleBeer(beer[index]);
    },
    itemCount: beer.length,
    shrinkWrap: true);

Widget _singleBeer(Product beer) => Container(
      margin: EdgeInsets.all(8),
      // height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 3,
            color: Colors.black12,
          )
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.cyan.withOpacity(0.8),
      ),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(beer.image_url),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${beer.name}'),
                              IconButton(
                                  icon: Icon(Icons.favorite), onPressed: null),
                            ],
                          ),
                          Text('subtitel'),
                          Row(
                            children: [Icon(Icons.money), Text('${beer.id}')],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );

Future<Response> getListBeerFromApi() async {
  const url = 'https://api.punkapi.com/v2/beers/';

  return await http.get(url);
}

class GettingBeerListInteractor {
  Future<List<Product>> execute({String query}) async {
    try {
      Response response = await getListBeerFromApi();
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Product> result = data.map((e) => Product.fromJson(e)).toList();
        return result;
      } else {
        print('Error');
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}
