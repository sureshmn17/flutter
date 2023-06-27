import 'package:flutter_mvvm_code/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG= "PREFS_KEY_LANG";
class AppPreferences{

  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async{
    String? langugae= _sharedPreferences.getString(PREFS_KEY_LANG);

    if(langugae !=null && langugae.isNotEmpty ){
      return langugae;
    }else{
      return LanguageType.ENGLISH.getValue();
    }
  }
}