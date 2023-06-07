import 'package:rxdart/rxdart.dart';

import 'app_step.dart';

class StepperController {

  int _stepMaxIndex = 0;

  final BehaviorSubject<int?> _activeController = BehaviorSubject<int?>();
  Stream<int?> get activeStep => _activeController.stream;

  final BehaviorSubject<List<AppStep>> _stepsController = BehaviorSubject<List<AppStep>>();
  Stream<List<AppStep>> get steps => _stepsController.stream;


  StepperController(List<AppStep> steps){
    _stepsController.add(steps);
    _stepMaxIndex = steps.length -1;
  }

  gotoNextPage(){
    int? currentStep = _activeController.hasValue?_activeController.value: 0;
    _markDone(currentStep!);
    if (currentStep < _stepMaxIndex) {
      _activeController.add(currentStep+1);
    }
  }

  goToPreviousPage(){
    int currentStep = _activeController.value?? 0;
    _markUnDone(currentStep);
    if (currentStep > 0) {
      _markUnDone(currentStep-1);
      _activeController.add(currentStep-1);
    }
  }

  resetStepperState(){
    _markDone(0);
    _stepMaxIndex=0;
    _getValidIndex(0);
    _markUnDone(0);
    setActive(0);
  }

  setActive(int index){
    _activeController.add(index);
  }

  _markDone(int index){
    int workingIndex = _isIndexValid(index) ? index : _getValidIndex(index);

    List<AppStep> list = _stepsController.value;
    list[workingIndex].isValid = true;

    _stepsController.add(list);
  }

  _markUnDone(int index){
    int workingIndex = _isIndexValid(index) ? index : _getValidIndex(index);

    List<AppStep> list = _stepsController.value;
    list[workingIndex].isValid = false;

    _stepsController.add(list);
  }

  int _getValidIndex(int index) {
    if (index > _stepMaxIndex) {
      return _stepMaxIndex;
    } else if (index < 0) {
      return 0;
    } else {
      return index;
    }
  }

  bool _isIndexValid(int index) {
    return index > _stepMaxIndex || index < 0;
  }

  dispose(){
    _activeController.close();
    _stepsController.close();
  }

}