import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/sound_profiles.dart';

class SwitchSound extends StatefulWidget {
  @override
  _SwitchSoundState createState() => _SwitchSoundState();
}

class _SwitchSoundState extends State<SwitchSound> {
  String _soundMode = '???';
  String _permissionStatus;
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    getCurrentSoundMode();
    getPermissionStatus();
    _isButtonDisabled = false;
  }

  Future<void> getCurrentSoundMode() async {
    String ringerStatus;
    try {
      ringerStatus = await SoundMode.ringerModeStatus;
      if (Platform.isIOS) {
        await Future.delayed(Duration(milliseconds: 1000), () async {
          ringerStatus = await SoundMode.ringerModeStatus;
        });
      }
    } catch (err) {
      ringerStatus = '$err';
    }
    if (!mounted) return;

    setState(() {
      _soundMode = ringerStatus;
    });
  }

  Future<void> getPermissionStatus() async {
    bool permissionStatus = false;
    try {
      permissionStatus = await PermissionHandler.permissionsGranted;
      print(permissionStatus);
    } catch (err) {
      print(err);
    }

    setState(() {
      _permissionStatus = permissionStatus
          ? "разрешение дано"
          : "нет разрешения, откройте настройки";
      _isButtonDisabled = permissionStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Icon(Icons.arrow_back)),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Настройки'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Инфо: $_soundMode\n $_permissionStatus'),
              _settingPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingPage() {
    switch (_isButtonDisabled) {
      case true:
        {
          return _buttons();
        }
      case false:
        {
          return _settings();
        }
        return Container();
    }
  }

  Widget _buttons() {
    return Column(
      children: [
        RaisedButton(
          onPressed: () => setNormalMode(),
          child: Text('Включить звук'),
        ),
        RaisedButton(
          onPressed: () => setSilentMode(),
          child: Text('Беззвучный режим'),
        ),
        RaisedButton(
          onPressed: () => setVibrateMode(),
          child: Text('Вибро'),
        ),
      ],
    );
  }

  Widget _settings() {
    return RaisedButton(
      onPressed: () => openDoNotDisturbSettings(),
      child: Text('открыть настройки'),
    );
  }

  Future<void> setSilentMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.SILENT);

      setState(() {
        _soundMode = message;
      });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  Future<void> setNormalMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.NORMAL);
      setState(() {
        _soundMode = message;
      });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  Future<void> setVibrateMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.VIBRATE);

      setState(() {
        _soundMode = message;
      });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  Future<void> openDoNotDisturbSettings() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }
}
