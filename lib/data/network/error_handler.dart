import 'package:dio/dio.dart';

import 'failure.dart';

enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUESt,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUNT,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioException){
      //dio Error its error from response of the Api
      failure=_handleError(error);
    }else{
      //default error
      failure=DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error){
    switch(error.type){
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badResponse:
        switch(error.response!.statusCode){
          case ResponseCode.BAD_REQUESt:
            return DataSource.BAD_REQUESt.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUNT:
            return DataSource.NOT_FOUNT.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      /*case DioExceptionType.unknown:
        return DataSource.DEFAULT.getFailure();*/
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this) {
      case DataSource.BAD_REQUESt:
        return Failure(ResponseCode.BAD_REQUESt,ResponseMessage.BAD_REQUESt);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN,ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED,ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUNT:
        return Failure(ResponseCode.NOT_FOUNT,ResponseMessage.NOT_FOUNT);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT,ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL,ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT,ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT,ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR,ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT,ResponseMessage.DEFAULT);
      default:
        return Failure(ResponseCode.DEFAULT,ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode{
  //Api status code
  static const int SUCCESS=200;  //success with dat
  static const int NO_CONTENT=201; //success with no content
  static const int BAD_REQUESt=400; //failure, api rejected the request
  static const int FORBIDDEN=403;//failure, api rejected the request
  static const int UNAUTHORISED=401;//failure, user is not authorised
  static const int NOT_FOUNT=204;//failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR=500;// failure, crash happened in server side


  //local status code
  static const int DEFAULT=-1;
  static const int CONNECT_TIMEOUT=-2;
  static const int CANCEL=-3;
  static const int RECEIVE_TIMEOUT=-4;
  static const int SEND_TIMEOUT=-5;
  static const int CACHE_ERROR=-6;
  static const int NO_INTERNET_CONNECTION=-7;

}

class ResponseMessage{
  //Api status code
  static const String SUCCESS="Success";  //success with dat
  static const String NO_CONTENT="Success with no content"; //success with no content
  static const String BAD_REQUESt="Bad request,try again later"; //failure, api rejected the request
  static const String FORBIDDEN="forbidden request, try again later";//failure, api rejected the request
  static const String UNAUTHORISED="user is unauthorised, try again later";//failure, user is not authorised
  static const String NOT_FOUNT="Url is not found, try again later";//failure, api url is not correct and not found
  static const String INTERNAL_SERVER_ERROR="some thing went wrong, try again later";// failure, crash happened in server side

  //local status code
  static const String DEFAULT="some thing went wrong, try again later";
  static const String CONNECT_TIMEOUT="time out error, try again later";
  static const String CANCEL="request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT="time out error, try again later";
  static const String SEND_TIMEOUT="time out error, try again later";
  static const String CACHE_ERROR="Cache error, try again later";
  static const String NO_INTERNET_CONNECTION="Please check your internet connection";
}

class ApiInternalStatus{
  static const int SUCCESS=200;
  static const int FAILURE=401;
}