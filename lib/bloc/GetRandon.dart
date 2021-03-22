import 'package:flutter/material.dart';
import 'package:vipusk_project/screen/RandomScreen.dart';

class GetRandom extends StatefulWidget {
  @override
  _GetRandomState createState() => _GetRandomState();
}

class _GetRandomState extends State<GetRandom>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _rotateAnimation;
  Animation<double> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _rotateAnimation = Tween(end: 0.15, begin: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.bounceInOut),
      ),
    );

    _slideAnimation = Tween(begin: 0.0, end: 800.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RandomScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _slideAnimation,
          child: RotationTransition(
            turns: _rotateAnimation,
            child: ElevatedButton(
                style: ButtonStyle(),
                child: const Text('испытать удачу'),
                onPressed: () {
                  _controller.forward();
                }),
          ),
          builder: (context, child) => Container(
              margin: EdgeInsets.only(
                left: 25,
                top: _slideAnimation.value,
              ),
              child: child),
        ),
      ],
    );
  }
}
