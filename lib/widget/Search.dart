import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.amber),
          prefixIcon: Icon(Icons.search, color: Colors.amber),
          hintText: 'Поиск по пивку',
        ),
      ),
    );
  }
}
