import 'package:flutter/material.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';
import '../ListTile.dart';
import '../widget/BottomListView.dart';

class TopListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          FutureBuilder(
            future: loadListBeer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return beerWidget(snapshot.data);
              } else if (snapshot.hasError) {
                print('Error');
              }
              return Container();
            },
          );
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ItemScreen(),
          //     ),
          //   );
          // },
          // );
        },
        separatorBuilder: (context, index) => Text('  '),
        itemCount: 30,
      ),
    );
  }
}
