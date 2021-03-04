import 'package:flutter/material.dart';
import 'package:vipusk_project/widget/BottomListView.dart';
import 'package:vipusk_project/widget/Search.dart';
import 'package:vipusk_project/widget/Select.dart';
import 'package:vipusk_project/widget/TopListView.dart';
import 'CartScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Привет Аркадий!',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text('Пить будешь, или как?',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    IconButton(
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
                        })
                  ],
                ),
              ),
              Search(),
              Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 5,
                    left: 30,
                  ),
                  child: Text(
                    'Представь, что по скидке',
                    style: TextStyle(fontSize: 16),
                  )),
              TopListView(),
              Select(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: BottomListView()),
            ],
          ),
        ),
      ),
    );
  }
}

// FutureBuilder(
//     future: fetchProducts(),
//     builder: (contex, snaphot) => snaphot.data != null
//         ? Container(
//             margin: EdgeInsets.symmetric(horizontal: 30),
//             child: RowList(
//               items: snaphot.data,
//             ))
//         : CircularProgressIndicator()),
