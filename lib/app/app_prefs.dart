import 'package:flutter_mvvm_code/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG= "PREFS_KEY_LANG";
const String PREFS_KEY_DASHBOARD= "PREFS_KEY_DASHBOARD";
const String PREFS_KEY_IS_USER_LOGGED_IN= "PREFS_KEY_IS_USER_LOGGED_IN";
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

  Future<void> setOnDashboardScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_DASHBOARD, true);
  }
  Future<bool> isOnDashboardScreenViewed() async{
    return _sharedPreferences.getBool(PREFS_KEY_DASHBOARD) ?? false;
  }
  Future<void> setIsUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }
  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}