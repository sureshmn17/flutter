import 'package:flutter/material.dart';

class ColorManager{
  
  /*without opacity (i.e.,full opacity)*/
  static Color primary=HexColor.fromHex("#89BA4B");
  static Color primaryDark=HexColor.fromHex("#B9318");
  static Color primaryLightColor=HexColor.fromHex("#89BA4B");
  static Color yelloShadeColor=HexColor.fromHex("#F2BC1A");
  static Color yelloLightColor=HexColor.fromHex("#89BA4B");
  static Color textYelloShadeColor=HexColor.fromHex("#E0AF00");

  static Color black=HexColor.fromHex("#000000");
  static Color greyDark=HexColor.fromHex("#212121");
  static Color lightGrey=HexColor.fromHex("#e0e0e0");
  static Color grey=HexColor.fromHex("#808080");
  static Color grey1=HexColor.fromHex("#707070");
  static Color grey2=HexColor.fromHex("#797979");
  static Color white=HexColor.fromHex("#FFFFFF");
  static Color error=HexColor.fromHex("#e61f34");

  static Color gray50=HexColor.fromHex("#fafafa");
  static Color gray100=HexColor.fromHex("#f5f5f5");
  static Color gray200=HexColor.fromHex("#eeeeee");
  static Color gray300=HexColor.fromHex("#e0e0e0");
  static Color gray400=HexColor.fromHex("#bdbdbd");
  static Color gray500=HexColor.fromHex("#9e9e9e");
  static Color gray600=HexColor.fromHex("#757575");
  static Color gray700=HexColor.fromHex("#616161");
  static Color gray800=HexColor.fromHex("#424242");
  static Color gray900=HexColor.fromHex("#212121");

/*with opacity*/
  static Color primaryOpacity70=HexColor.fromHex("#83ED9728");
}
extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString=hexColorString.replaceAll('#', '');
    if(hexColorString.length==6){
      hexColorString="FF"+hexColorString;//8 char with opacity 100%
    }
    return Color(int.parse(hexColorString,radix: 16));
  }
}