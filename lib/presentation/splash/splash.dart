import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? _timer;

  _startDelay(){
    _timer=Timer(Duration(seconds: 2),_goNext);
  }

  _goNext(){
    Navigator.pushReplacementNamed(context,Routes.loginRoute);
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(child: const Image(image: AssetImage(ImageAssets.splashLogo),)),
    );
  }
}
