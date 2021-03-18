import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Battary extends StatefulWidget {
  @override
  _BattaryState createState() => _BattaryState();
}

AnimationController _controller;
Animation<double> _slideAnimation;
Tween<double> tween = Tween(begin: 212.0, end: 0.0);
bool selected = false;
double anim;

class _BattaryState extends State<Battary> with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _slideAnimation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Battery Level';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    double batteryLevelAnim;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result %';
      batteryLevelAnim = (result).toDouble();
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
      anim = batteryLevelAnim;
    });
  }

  Future<void> _onTap() async {
    await _getBatteryLevel();
    _controller.forward();
    selected = !selected;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Battery Level'),
              onPressed: () => _onTap(),
            ),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan,
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(1),
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  // child: AnimatedBuilder(
                  //   animation: _slideAnimation,
                  //   builder: (context, child) => Center(
                  //       child: Container(
                  //     // margin: EdgeInsets.only(
                  //     //   top: _slideAnimation.value,
                  //     // ),
                  //     decoration: BoxDecoration(color: Colors.grey),
                  //   )),
                  //   child: Center(
                  //     child: Text(_batteryLevel),
                  //   ),
                  // ),

                  // child: Center(
                  //   child: AnimatedContainer(
                  //     height: selected ? anim : 0,
                  //     width: selected ? 100 : 0,
                  //     color: selected ? Colors.red : Colors.blue,
                  //     alignment: selected
                  //         ? Alignment.topRight
                  //         : AlignmentDirectional.topCenter,
                  //     duration: const Duration(seconds: 2),
                  //     curve: Curves.fastOutSlowIn,
                  //   ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
