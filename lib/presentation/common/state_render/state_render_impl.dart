import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/common/state_render/state_render.dart';
import 'package:flutter_mvvm_code/presentation/resources/strings_manager.dart';

import '../../../data/mapper/mapper.dart';


abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//Loading state (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType,String? message}):
  message=message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}

//error state (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType,this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}

//CONTENT STATE
class ContentState extends FlowState {

  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;

}

//EMPTY STATE
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;

}

extension FlowStateExtension on FlowState
{
  Widget getScreenWidget(BuildContext context,
      Widget contentScreenWidget,
      Function retryActionFunction)
  {
    switch(this.runtimeType){
      case LoadingState:
      {
        if(getStateRendererType() == StateRendererType.POPUP_LODING_STATE)
        {
          //showing popup dialog
          showPopUp(context,getStateRendererType(),
              getMessage());
          //return the content ui of the screen
         return contentScreenWidget;
        }
        else //StateRendererType.FULL_SCREEN_LOADING_STATE
        {

          return StateRenderer(stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      }
      case ErrorState:
      {
        dismissDialog(context);
        if(getStateRendererType() == StateRendererType.POPUP_ERROR_STATE)
        {
          //showing popup dialog
          showPopUp(context,getStateRendererType(),
              getMessage());
          //return the content ui of the screen
          return contentScreenWidget;
        }
        else //StateRendererType.FULL_SCREEN_LOADING_STATE
        {
          return StateRenderer(stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      }
      case ContentState:
      {
        dismissDialog(context);
        return contentScreenWidget;
      }
      case EmptyState:
      {
        return StateRenderer(stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction);
      }
      default:
      {
        return contentScreenWidget;      }
    }
   
  }

  dismissDialog(BuildContext context){
    if(_isThereCurrebtDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
  _isThereCurrebtDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent !=true;
  showPopUp(BuildContext context,StateRendererType stateRendererType,String message)
  {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(context: context,builder: (BuildContext context)=>StateRenderer(
          stateRendererType: stateRendererType,
          message: message,retryActionFunction: (){},))
    );
  }
}

