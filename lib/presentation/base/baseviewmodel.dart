import 'dart:async';

import 'package:flutter_mvvm_code/presentation/common/state_render/state_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs{
  final StreamController _inputStateStreamController =
         StreamController<FlowState>.broadcast();


  @override
  Sink get inputState =>  _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
  //shared variables and function that will be used through any view model.
}
abstract class BaseViewModelInputs{
  void start();//will be called while init. of view model
  void dispose();//will be callled when viewmodel dies.

 Sink get inputState;
}
abstract class BaseViewModelOutputs{
  Stream<FlowState> get outputState;
}