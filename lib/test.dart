import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/app/app.dart';

class Test extends StatelessWidget {

  const Test({Key? key}) : super(key: key);

  void updateAppState(){
    MyApp.instance.appState=10;
  }
  void getAppState(){
    print(MyApp.instance.appState);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
