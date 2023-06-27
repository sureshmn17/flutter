import 'dart:async';

import 'package:flutter_mvvm_code/presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_code/presentation/common/state_render/state_render.dart';
import 'package:flutter_mvvm_code/presentation/resources/strings_manager.dart';

import '../../domain/usecase/login_usecase.dart';
import '../common/freezed_data_classes.dart';
import '../common/state_render/state_render_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs,LoginViewModelOutputs{

  //Strem controllers
  final StreamController _userNameStreamController =
              StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
              StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
              StreamController<String>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
          StreamController<bool>();

  var loginObject = LoginObject("","");

  LoginUseCase _loginUseCase ; //todo remove ?

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    //view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;


  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;


  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _loginUseCase!.execute(LoginUseCaseInput(loginObject.userName,
        loginObject.password))).fold((failure)=>{
        //left -> failure
      inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message))
      //print(failure.message)
    },(data) {
           // right -> success(data)
          inputState.add(ContentState());

      // navigate to main screen after login
      isUserLoggedInSuccessfullyStreamController.add(true);


    });
  }
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password);//data class operation same as kotlin
    _validate();
  }

  @override
  setUsername(String username) {
   inputUsername.add(username);
   loginObject = loginObject.copyWith(
       userName: username);//data class operation same as kotlin
   _validate();
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));


  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController
      .stream.map((_) => _isAllInputsValid());

  //private functions

  _validate(){
    inputIsAllInputValid.add("");
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName){
    return userName.isNotEmpty && RegExp(AppStrings.emailMatches).hasMatch(userName);
  }

  bool _isAllInputsValid(){
    return _isPasswordValid(loginObject.password)
        && _isUserNameValid(loginObject.userName);
  }
}

//inputs mean the orders that our view model will receive from our view
abstract class LoginViewModelInputs{
  //three functions
  setUsername(String username);
  setPassword(String password);
  login();

  //two sinks for streams
  Sink get inputUsername;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

//outputs mean data or results that will be sent from our view model to our
abstract class LoginViewModelOutputs{
  Stream<bool> get outputIsUsernameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
