

//to convert the response into a non nullable object(model)

import 'package:flutter_mvvm_code/app/extension.dart';
import 'package:flutter_mvvm_code/data/responses/responses.dart';

import '../../domain/model/model.dart';

const EMPTY="";
const ZERO=0;

extension DataReponseMapper on DataResponse?{
  Data toDomain(){
   return Data(this?.token?.orEmpty() ?? EMPTY, this?.expiretoken?.orEmpty() ?? EMPTY,
       this?.userId?.orEmpty() ?? EMPTY, this?.userName?.orEmpty() ?? EMPTY,
       this?.email?.orEmpty() ?? EMPTY,
       this?.userType?.orZero() ?? ZERO,
       this?.mobileNo?.orEmpty() ?? EMPTY, this?.profilImage?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticateReponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(this?.dataResponse?.toDomain());
  }
}