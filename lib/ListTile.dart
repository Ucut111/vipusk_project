import 'package:flutter/material.dart';
import 'package:vipusk_project/screen/ItemScreen.dart';

class TileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(),
                ),
              );
            },
            child: Column(children: <Widget>[
              Text('', style: TextStyle(fontWeight: FontWeight.bold)),
              // Image.network(this.item.image_url),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(children: <Widget>[
                      Icon(Icons.account_balance_outlined),
                      Text("Price: "),
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
  }
}
// Widget build(BuildContext context) {
//   return Container(
//       padding: EdgeInsets.all(2),
//       height: 140,
//       child: Card(
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Expanded(child: Image.network(this.item.image_url)),
//               // Image.asset("assets/appimages/" + this.item.image_url),
//               Expanded(
//                   child: Container(
//                       padding: EdgeInsets.all(5),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text(this.item.name,
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('$this.item.id'),
//                           Text("Price: " + this.item.target_fg.toString()),
//                         ],
//                       )))
//             ]),
//       ));
// }
// }
