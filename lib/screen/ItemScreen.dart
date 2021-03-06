import 'package:flutter/material.dart';
import 'package:vipusk_project/Product.dart';

class ItemScreen extends StatelessWidget {
  final Product beer;

  ItemScreen({@required this.beer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
            child: Column(
          children: [
            // Image.network(this.item.image_url),
            Text(''),
            Text(''),
            Text(''),
          ],
        )),
      ),
    );
  }
}
