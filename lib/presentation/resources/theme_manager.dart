import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/font_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/styles_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    //main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLightColor,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.grey1,
    //ripple color
    splashColor: ColorManager.primaryOpacity70,
      // will disabled button example
    hintColor: ColorManager.grey,

    //card view theme
   cardTheme: CardTheme(
     color: ColorManager.white,
     shadowColor: ColorManager.grey,
     elevation: AppSize.s4
   ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16)
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
       textStyle: getRegularStyle(color: ColorManager.white),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12))
      )
    ),
    
    //Text theme

    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.greyDark,fontSize: FontSize.s16),
      titleMedium: getMediumStyle(color:ColorManager.lightGrey,fontSize: FontSize.s14),
      bodySmall: getRegularStyle(color:ColorManager.grey1),
      bodyLarge: getRegularStyle(color:ColorManager.grey)),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      //label style
      labelStyle: getMediumStyle(color: ColorManager.greyDark),
      //erroe style
      errorStyle: getRegularStyle(color: ColorManager.error),
        //enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
    ),
      //focused border
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      //error border
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      //focused error border
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),
    )
    //input decoration theme (text form field)

  );
}