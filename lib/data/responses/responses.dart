import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  var status;

  @JsonKey(name: "message")
  String? message;


}
@JsonSerializable()
class DataResponse{
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "expiretoken")
  String? expiretoken;
  @JsonKey(name: "userId")
  String? userId;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "userType")
  int? userType;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "profilImage")
  String? profilImage;
  DataResponse(this.token,this.expiretoken,this.userId,this.userName,this.userType,
      this.mobileNo,this.profilImage);

  //from json
  factory DataResponse.fromJson(Map<String,dynamic> json)=>
      _$DataResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=>_$DataResponseToJson(this);
}
/*
* "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJUcmFja0Nob3Jlc0FwcCIsImp0aSI6IjgzYjM5NWY0LWM5MDQtNDMxMi1hZWZjLTViODY0ZWNkNDUzOCIsIlVzZXJOYW1lIjoiU3VyZXNoIiwiUGFzc3dvcmQiOiIxMjM0NTYiLCJleHAiOjE2OTUwMTQ1MTgsImlzcyI6IlRyYWNrQ2hvcmVzQXBwIiwiYXVkIjoiVHJhY2tDaG9yZXNBcHAifQ.gYJ-SH1UOJOEKOKhkZdm2hIbe2zE6gfsTmMhu_IwNPE",
    "expiretoken": "2023-09-18T01:21:58.81288-04:00",
    "userId": "494a2983-7c4a-4b5e-a18a-28dda8735d3b",
    "userName": "Suresh",
    "email": "sureshkumar.n@knila.com",
    "userType": 1,
    "mobileNo": "8667867974",
    "profilImage": "http://72.249.77.205:8084/MyFile/Suresh24-05-2023_08_40_09_342.png"
  }
*
* */

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  DataResponse? dataResponse;

  AuthenticationResponse(this.dataResponse);
  //from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=>
      _$AuthenticationResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=>_$AuthenticationResponseToJson(this);
}