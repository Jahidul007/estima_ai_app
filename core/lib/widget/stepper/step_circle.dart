import 'package:flutter/material.dart';
import 'app_step.dart';
import 'step_state.dart';


class StepCircle extends StatelessWidget {
  final AppStep step;
  final double? circleRadius;
  final double? circlePaddingFromBorder;

  final Color? selectedColor;
  final Color? unSelectedColor;

  Color? selectedOuterCircleColor;
  Color? unSelectedOuterCircleColor;

  final Color? selectedIconColor;
  final Color? unSelectedIconColor;

  StepCircle({
    Key? key,
    required this.step,
    this.circleRadius,
    this.selectedColor,
    this.unSelectedColor = Colors.grey,
    this.selectedOuterCircleColor,
    this.circlePaddingFromBorder,
    this.unSelectedOuterCircleColor,
    this.selectedIconColor,
    this.unSelectedIconColor,
  }) : super(key: key) {
    selectedOuterCircleColor ??= selectedColor;
    unSelectedOuterCircleColor ??= unSelectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleRadius,
      width: circleRadius,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: _getColor()!,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(circleRadius!),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          circlePaddingFromBorder!,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: step.state == StepperState.Active
                ? selectedColor
                : unSelectedColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                circleRadius!,
              ),
            ),
          ),
          child: _getChild(),
        ),
      ),
    );
  }

  Widget _getChild() {
    if (step.iconData != null) {
      return _getImage();
    } else if (step.number != null) {
      if (step.isValid && step.state == StepperState.Active) {
        return _getTick();
      } else {
        return _getNumber();
      }
    } else {
      return Container();
    }
  }

  _getNumber() {
    return Center(
      child: Text(
        step.number!,
        style: TextStyle(
            color: step.state == StepperState.Active
                ? selectedIconColor ?? selectedOuterCircleColor
                : unSelectedIconColor ?? unSelectedOuterCircleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _getTick() {
    return Center(
      child: Icon(
        Icons.done,
        color: selectedIconColor ?? selectedOuterCircleColor,
        size: 16,
      ),
    );
  }

  _getImage() {
    return Center(
      child: Icon(
        step.iconData,
        color: step.state == StepperState.Active
            ? selectedIconColor ?? selectedOuterCircleColor
            : unSelectedIconColor ?? unSelectedOuterCircleColor,
        size: 16,
      ),
    );
  }

  Color? _getColor() {
    if (step.state == StepperState.Active) {
      return selectedOuterCircleColor ?? selectedColor;
    }
    return unSelectedOuterCircleColor ?? unSelectedColor;
  }
}
