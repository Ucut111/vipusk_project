import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Battary extends StatefulWidget {
  @override
  _BattaryState createState() => _BattaryState();
}

class _BattaryState extends State<Battary> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Battery Level';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result %';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: GestureDetector(
          onTap: () => _getBatteryLevel(),
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyan,
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ),
                    ),
                    Center(child: Text(_batteryLevel)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
