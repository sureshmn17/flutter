

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/dashboard/dashboard.dart';
import 'package:flutter_mvvm_code/presentation/forget_password/forget_password.dart';
import 'package:flutter_mvvm_code/presentation/home/home.dart';
import 'package:flutter_mvvm_code/presentation/login/login.dart';
import 'package:flutter_mvvm_code/presentation/onboarding/onboarding.dart';
import 'package:flutter_mvvm_code/presentation/register/register.dart';
import 'package:flutter_mvvm_code/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_code/presentation/splash/splash.dart';

import '../../app/di.dart';

class Routes{
  static const String splash="/";
  static const String onBoardingRoute="/onboarding";
  static const String loginRoute="/login";
  static const String registerRoute="/register";
  static const String forgotRoute="/forgotPassword";
  static const String mainRoute="/main";
  static const String home="/home";
  static const String dashboard="/dashboard";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.splash:
        return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_)=>const DashBoardView());
      case Routes.loginRoute:
        intitLoginModule();
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.home:
        return MaterialPageRoute(builder: (_)=>const HomeView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      case Routes.forgotRoute:
        return MaterialPageRoute(builder: (_)=>const ForgetPasswordView());
      default:
        return undeineRoute();
    }
  }
  static Route<dynamic> undeineRoute(){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(appBar: AppBar(title: Text(AppStrings.noRouteFound),),
    body: Center(child: Text(AppStrings.noRouteFound)),));

  }
}