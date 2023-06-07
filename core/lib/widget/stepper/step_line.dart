import 'package:flutter/material.dart';
import 'app_step.dart';
import 'step_state.dart';

class StepLine extends StatelessWidget {
  final AppStep step;
  final Color selectedColor;
  final Color unSelectedColor;

  const StepLine(this.step, this.selectedColor, this.unSelectedColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      height: 2,
      color:
          step.state == StepperState.Active ? selectedColor : unSelectedColor,
    );
  }
}
