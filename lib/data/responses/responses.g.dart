// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status']
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      json['token'] as String?,
      json['expiretoken'] as String?,
      json['userId'] as String?,
      json['userName'] as String?,
      json['userType'] as int?,
      json['mobileNo'] as String?,
      json['profilImage'] as String?,
    )..email = json['email'] as String?;

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiretoken': instance.expiretoken,
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'userType': instance.userType,
      'mobileNo': instance.mobileNo,
      'profilImage': instance.profilImage,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['data'] == null
          ? null
          : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status']
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.dataResponse,
    };
