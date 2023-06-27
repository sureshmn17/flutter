import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/app/di.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp()); //inistate app
}

