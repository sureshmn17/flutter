import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/routes_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  _startDelay(){
    _timer=Timer(Duration(seconds: 2),_goNext);
  }

  _goNext(){

    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {

    if(isUserLoggedIn){
      // navigate to main screen
      Navigator.pushReplacementNamed(context,Routes.dashboard)
    }else{
      _appPreferences.isOnDashboardScreenViewed().then((isOnDashboardScreenViewed) =>
      {
        if(isOnDashboardScreenViewed){
          Navigator.pushReplacementNamed(context,Routes.loginRoute)
        }else{
          Navigator.pushReplacementNamed(context,Routes.dashboard)
        }

      })
    }
  });
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
