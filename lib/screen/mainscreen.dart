import 'package:flutter/material.dart';
import 'package:vipusk_project/bloc/BottomListView_pattern.dart';
import 'package:vipusk_project/bloc/GetRandon.dart';
import 'package:vipusk_project/bloc/TopListView_pattern.dart';
import 'package:vipusk_project/bloc/beer_pattern_bloc.dart';
import 'package:vipusk_project/widget/Select.dart';
import '../repository.dart';
import 'SettingScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _bloc = BeersPatternBloc(Repository());

  @override
  void initState() {
    super.initState();
    _bloc.navigateTo.listen((page) async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => page));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
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
                                Icons.settings,
                                color: Colors.pink,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SwitchSound(),
                                    ));
                              })
                        ])),
                GetRandom(),
                TopListView(),
                Select(),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: BottomListView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
