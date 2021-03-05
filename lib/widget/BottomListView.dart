import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vipusk_project/Product.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BottomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) => FutureBuilder(
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
            itemCount: 10,
            // crossAxisCount: 2,
            // staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 10),
            // mainAxisSpacing: 8,
            // crossAxisSpacing: 8,
          ),
        ),
        // SizedBox(
        //   height: 500,
        // ),
      ],
    );
  }
}

Future<List<Product>> loadListBeer() async =>
    await GettingBeerListInteractor().execute();

Widget beerWidget(List<Product> beer) => ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return _singleBeer(beer[index]);
    },
    itemCount: beer.length,
    shrinkWrap: true);

Widget _singleBeer(Product beer) => Container(
      margin: EdgeInsets.all(20),
      width: 150,
      height: 100,
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
          GestureDetector(
            // ПЕРЕНЕСТИ В НАЧАЛО
            // onTap: () {
            //   Navigator.push(
            //     index,
            //     MaterialPageRoute(
            //       builder: (context) => ItemScreen(),
            //     ),
            //   );
            // },
            child: Column(children: <Widget>[
              Row(
                children: [
                  Image.network(
                    beer.image_url,
                    scale: 20,
                  ),
                  Text('${beer.name}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(children: <Widget>[
                      Icon(Icons.account_balance_outlined),
                      Text("Price: ${beer.id}"),
                    ]),
                  ),
                  IconButton(icon: Icon(Icons.plus_one_sharp), onPressed: null),
                ],
              ),
            ]),
          ),
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
