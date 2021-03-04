import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  int _selected = 0;
  List categories = ['Горячее', "Вчерашнее", 'Первое', 'Второе'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        // horizontal: 30,
      ),
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              _selected = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              // vertical: 10,
              horizontal: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              //  vertical: 3
            ),
            child: index == _selected
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(categories[index],
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Text(categories[index],
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                  ),
          ),
        ),
      ),
    );
  }
}
