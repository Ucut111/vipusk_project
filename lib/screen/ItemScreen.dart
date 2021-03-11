import 'package:flutter/material.dart';
import 'package:vipusk_project/Product.dart';

import 'CartScreen.dart';

class ItemScreen extends StatelessWidget {
  final Beer beer;

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
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://p1.zoon.ru/9/4/5a3bc7b6a24fd9259f42127a_5ab8e1b6dcb96.jpg'),
            fit: BoxFit.cover,
          )),
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
                Text(''),
                Text(''),
              ],
            )),
          )),
    ));
  }
}
