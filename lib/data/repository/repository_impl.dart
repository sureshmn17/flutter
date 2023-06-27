import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_code/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_code/data/mapper/mapper.dart';
import 'package:flutter_mvvm_code/data/network/error_handler.dart';
import 'package:flutter_mvvm_code/data/network/failure.dart';
import 'package:flutter_mvvm_code/data/request/request.dart';
import 'package:flutter_mvvm_code/domain/model/model.dart';
import 'package:flutter_mvvm_code/domain/repository/repository.dart';

import '../network/network_info.dart';

class RepositoryImpl extends Repository{
  RemoteDataSouce _remoteDatatSource;
  NetworkInfo _netWorkInfo;
  RepositoryImpl(this._remoteDatatSource,this._netWorkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async{

    if(await _netWorkInfo.isConnected)
    {
      try{
        //its safe to call the Api
        final response=await _remoteDatatSource.login(loginRequest);
        int status=int.parse(response.status.toString());
        if(status == ApiInternalStatus.SUCCESS)
        {
          //return data (success)
          //return right
          return Right(response.toDomain());

        }else{
          //return biz logic error

          // return left
          //return Left(Failure(401,response.message.toString()));
          return Left(Failure(status??ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT)); //Failure, Left
        }
      }catch(error){
        //return Left(Failure(401,"response.message.toString()"));

        return(Left(ErrorHandler.handle(error).failure));

      }


    }else{
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}
