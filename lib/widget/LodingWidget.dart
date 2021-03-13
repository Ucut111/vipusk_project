import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
