enum LanguageType{ ENGLISH, ARABIC}
const String ARABIC= "ar";
const String ENGLISH= "en";

extension LangugaeTypeExtension on LanguageType{
  String getValue(){

    switch (this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}