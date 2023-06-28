import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_code/app/di.dart';
import 'package:flutter_mvvm_code/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_code/data/repository/repository_impl.dart';
import 'package:flutter_mvvm_code/domain/repository/repository.dart';
import 'package:flutter_mvvm_code/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm_code/presentation/common/state_render/state_render_impl.dart';
import 'package:flutter_mvvm_code/presentation/login/login_viewmodel.dart';
import 'package:flutter_mvvm_code/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/styles_manager.dart';

import '../../app/app_prefs.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import 'componets/login_top.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  final LoginViewModel  _viewModel = instance<LoginViewModel>() ;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppPreferences  _appPreferences = instance<AppPreferences>() ;
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  _bind(){
     _viewModel.start();
     _userNameController.addListener(()=> _viewModel.setUsername(_userNameController.text));
     _passwordController.addListener(()=> _viewModel.setPassword(_passwordController.text));
     _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isSuccessLoggedIn) {
       //navigate to main screen

       SchedulerBinding.instance.addPostFrameCallback((_) {
         _appPreferences.setIsUserLoggedIn();
         Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
       });
     });
  }
  @override
  void initState() {
    _bind();
    super.initState();
    passwordVisible = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
            _viewModel.login();
          })??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[
          const LoginScreenTop(),
          Padding(
              padding:  const EdgeInsets.fromLTRB(AppPadding.p16,AppPadding.p12, AppPadding.p0, AppPadding.p0),
              child: Align(
                alignment: Alignment.topLeft,
                child:Text(AppStrings.signInToContinue,textAlign: TextAlign.start,
                    style:getBoldStyle(fontSize: AppSize.s20,color: ColorManager.primary)),
              )
          )
          ,
          const SizedBox(height: AppHeight.h48,),
          Row(
            children: [
              Spacer(),
              Expanded(flex: AppFlex.f16,
                child:Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: AppPadding.p0,right: AppPadding.p0),
                          child: StreamBuilder<bool>(
                            stream: _viewModel.outputIsUsernameValid,
                            builder: (context,snapshot){
                              return TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _userNameController,
                                textInputAction: TextInputAction.next,
                                style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s13),
                                cursorColor: Colors.green,
                                //onSaved: (email) {},
                                /*validator: (value) {
                                    if (value == null || value.isEmpty ||
                                        !RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                      return AppStrings.validemail;
                                    }
                                    return null;
                                  },*/
                                decoration:  InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: AppStrings.emailID,
                                    errorText: (snapshot.data ?? true)
                                        ? null: AppStrings.validemail,
                                    suffixIcon: Padding(padding: const EdgeInsets.all(AppPadding.p12),
                                      child: Icon(Icons.email, color: ColorManager.primary,),)
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height:  AppHeight.h5),
                        Padding(
                          padding: EdgeInsets.only(left: AppPadding.p0,top:AppPadding.p25,right: AppPadding.p0),
                          child: StreamBuilder<bool>(
                            stream: _viewModel.outputIsPasswordValid,
                            builder: (context,snapshot){
                              return TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                obscureText: passwordVisible,
                                textInputAction: TextInputAction.done,
                                style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s13),
                                cursorColor:ColorManager.primary,
                                // onSaved: (email) {},
                                /*validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a valid password!';
                                      }
                                      return null;
                                    },*/

                                decoration:  InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: AppStrings.password,
                                    errorText: (snapshot.data ?? true)
                                        ? null: AppStrings.validpassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off, color: ColorManager.primary,),
                                      onPressed: () {
                                        setState(
                                              () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },)
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: AppHeight.h5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(AppPadding.p16,
                              AppPadding.p12, AppPadding.p0, AppPadding.p0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  //Navigator.of(context).push(_createRoute());
                                },
                                child: Text(AppStrings.forgotPassword, textAlign: TextAlign.start,
                                  style: getRegularStyle(color: ColorManager.black,fontSize:AppSize.s14),

                                ),
                              )
                          ),
                        ),

                        const SizedBox(height: AppHeight.h12),
                        Padding(
                          padding: EdgeInsets.only(left: AppPadding.p0,right: AppPadding.p0),
                          child:StreamBuilder<bool>(
                            stream:_viewModel.outputIsAllInputsValid ,
                            builder: (context,snapshot){
                              return  ElevatedButton(
                                onPressed:  (snapshot.data ?? false)
                                    ? () {
                                  print(snapshot.toString());
                                  _viewModel.login();
                                }:null,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(AppPadding.p20,
                                      AppPadding.p5, AppPadding.p20, AppPadding.p5),
                                  child: Text(
                                    AppStrings.login.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: getRegularStyle(color: ColorManager.white,fontSize:AppSize.s14),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: AppHeight.h12),

                      ],
                    )
                ),
              ),
              Spacer(),
            ],
          ),
          RichText(
              text: TextSpan(
                  text: AppStrings.areYouANewUser,style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s14),
                  children: <TextSpan>[
                    TextSpan(text: AppStrings.signUp,style: getSemiBoldStyle(color: ColorManager.black,fontSize: AppSize.s16),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          //Navigator.of(context).push(_createRoute());
                        }
                    ),

                  ]

              )
          )
        ],
      ),);
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
