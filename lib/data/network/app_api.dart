

import 'package:dio/dio.dart';
import 'package:flutter_mvvm_code/app/constant.dart';
import 'package:retrofit/http.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient{

  factory AppServiceClient(Dio dio,{String baseUrl})=_AppServiceClient;

  @POST("/api/Authentication/Login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      @Field("deviceToken") String deviceToken,
      );
}