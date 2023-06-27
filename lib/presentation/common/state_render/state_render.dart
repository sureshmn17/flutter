import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/data/mapper/mapper.dart';
import 'package:flutter_mvvm_code/data/network/failure.dart';
import 'package:flutter_mvvm_code/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/font_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/styles_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType{
  //POPUP STATES
  POPUP_LODING_STATE,
  POPUP_ERROR_STATE,

  //FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,//THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE//EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget{
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;


  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction}) :
    message = message ?? AppStrings.loading,
    title = title ?? EMPTY,
    super(key: key);
  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){
    switch (stateRendererType) {
      case StateRendererType.POPUP_LODING_STATE:
        return _getPopUpDialog(context,[_getAnimatedImage(JsonAssets.loadingJson)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(AppStrings.ok,context)]);

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loadingJson),_getMessage(message)]);

      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(
            [
              _getAnimatedImage(JsonAssets.errorJson),
              _getMessage(message),
              _getRetryButton(AppStrings.retryAgain,context)
            ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();

      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.emptyJson),_getMessage(message)]);
      default:
       return Container();

    }

  }

  Widget _getPopUpDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0, AppSize.s12))
          ]

        ),
        child: _getDialogContent(context,children) ,
      ),
    );
  }
  Widget _getDialogContent(BuildContext context, List<Widget> children){

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppHeight.h100,
      width: AppHeight.h100,
      child:Lottie.asset(animationName), //json image

    );
  }
  Widget _getMessage(String message){
    return Padding(padding: const EdgeInsets.all(AppPadding.p18),
      child:Text(message,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),) ,);
  }

  Widget _getRetryButton(String buttonTitle,BuildContext context){
    return Center(
      child: Padding(
        padding:const EdgeInsets.all(AppPadding.p18) ,
        child: SizedBox(
          width: AppHeight.h180,
          child: ElevatedButton(onPressed: (){
            if(stateRendererType==StateRendererType.FULL_SCREEN_ERROR_STATE){
              retryActionFunction?.call();//to call the API function agiain to retry
            }else{
              Navigator.of(context).pop();//popup state error so weed to dismiss the dialog

            }

          },
              child: Text(buttonTitle)
          ) ,
        ) ,
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}