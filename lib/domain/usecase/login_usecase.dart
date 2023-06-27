import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_code/app/functions.dart';
import 'package:flutter_mvvm_code/data/network/failure.dart';
import 'package:flutter_mvvm_code/data/request/request.dart';
import 'package:flutter_mvvm_code/domain/model/model.dart';
import 'package:flutter_mvvm_code/domain/repository/repository.dart';
import 'package:flutter_mvvm_code/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{

  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async{
    DeviceInfo deviceInfo= await getDeviceDetails();
    return await _repository.login((LoginRequest(input.email,input.password,deviceInfo.identifier)));
  }
  
}

class LoginUseCaseInput{
  String email;
  String password;
  
  LoginUseCaseInput(this.email,this.password);
  
}