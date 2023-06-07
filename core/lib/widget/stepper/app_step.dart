import 'package:flutter/material.dart';
import 'step_state.dart';

class AppStep {
  final String? number;
  final String? title;
  final IconData? iconData;
  bool isValid;
  StepperState? state;

  AppStep({
    this.title,
    this.number,
    this.state = StepperState.Inactive,
    this.isValid = false,
    this.iconData,
  });
}

