import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
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
