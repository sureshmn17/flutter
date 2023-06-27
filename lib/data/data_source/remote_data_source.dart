import 'package:flutter_mvvm_code/data/request/request.dart';
import 'package:flutter_mvvm_code/data/responses/responses.dart';

import '../network/app_api.dart';

abstract class RemoteDataSouce{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplemeter implements RemoteDataSouce{
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplemeter(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email,loginRequest.password,loginRequest.deviceToken);
  }
  
}