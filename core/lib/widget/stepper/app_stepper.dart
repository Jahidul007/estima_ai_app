import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'app_step.dart';
import 'step_circle.dart';
import 'step_line.dart';
import 'step_state.dart';
import 'stepper_controller.dart';

const double PADDING_SMALL = 8;

class AppStepper extends StatefulWidget {
  final StepperController stepperController;

  final double circleRadius;
  final double textMargin;
  final double circlePaddingFromBorder;
  final Color selectedColor;
  final Color unSelectedColor;

  final Color selectedOuterCircleColor;
  final Color unSelectedOuterCircleColor;

  final Color selectedLineColor;
  final Color unSelectedLineColor;

  final Color selectedTextColor;
  final Color unSelectedTextColor;

  final Color selectedIconColor;
  final Color unSelectedIconColor;

  final TextStyle textStyle;
  final Function(int) onPageChange;

  final bool stepsClickable;

  AppStepper({
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    required this.textStyle,
    required this.circlePaddingFromBorder,
    required this.textMargin,
    required this.unSelectedOuterCircleColor,
    required this.selectedLineColor,
    required this.unSelectedLineColor,
    required this.selectedTextColor,
    required this.unSelectedTextColor,
    required this.selectedIconColor,
    required this.unSelectedIconColor,
    required this.onPageChange,
    required this.stepperController,
    required this.stepsClickable,
  });

  @override
  // ignore: public_member_api_docs, no_logic_in_create_state
  State<StatefulWidget> createState() => _AppStepperState(
        selectedColor: selectedColor,
        unSelectedColor: unSelectedColor,
        circleRadius: circleRadius,
        selectedOuterCircleColor: selectedOuterCircleColor,
        unSelectedOuterCircleColor: unSelectedOuterCircleColor,
        selectedLineColor: selectedLineColor,
        unSelectedLineColor: unSelectedLineColor,
        selectedTextColor: selectedTextColor,
        unSelectedTextColor: unSelectedTextColor,
        selectedIconColor: selectedIconColor,
        unSelectedIconColor: unSelectedIconColor,
        textStyle: textStyle,
        textMargin: textMargin,
        onPageChange: onPageChange,
        stepsClickable: stepsClickable,
        circlePaddingFromBorder: 0,
      );
}

class _AppStepperState extends State<AppStepper> {
  List<AppStep> steps = [];
  final Color selectedColor;
  final Color unSelectedColor;
  final double circleRadius;
  final double textMargin;
  final double circlePaddingFromBorder;
  final TextStyle textStyle;

  final Color selectedLineColor;
  final Color unSelectedLineColor;

  final Color selectedOuterCircleColor;
  final Color unSelectedOuterCircleColor;

  final Color selectedTextColor;
  final Color unSelectedTextColor;

  final Color selectedIconColor;
  final Color unSelectedIconColor;

  final bool? stepsClickable;

  int currentStep = 0;

  final Function(int) onPageChange;

  _AppStepperState({
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    required this.textStyle,
    required this.circlePaddingFromBorder,
    required this.textMargin,
    required this.unSelectedOuterCircleColor,
    required this.selectedLineColor,
    required this.unSelectedLineColor,
    required this.selectedTextColor,
    required this.unSelectedTextColor,
    required this.selectedIconColor,
    required this.unSelectedIconColor,
    required this.onPageChange,
    required this.stepsClickable,
  });

  int _getValidIndex(int index) {
    if (index > steps.length) {
      return steps.length;
    } else if (index < 0) {
      return 0;
    } else {
      return index;
    }
  }

  bool _isIndexValid(int index) {
    return index > steps.length - 1 || index < 0;
  }

  @override
  void initState() {
    super.initState();
  }

  void changeStatus(int index) {
    if (isForward(index)) {
      markAsCompletedForPrecedingSteps(index);
    } else {
      markAsUnselectedToSucceedingSteps();
    }
    currentStep = index;
    steps[index].state = StepperState.Active;
    onPageChange(currentStep);
  }

  void markAsUnselectedToSucceedingSteps() {
    for (int i = steps.length - 1; i >= currentStep; i--) {
      steps[i].state = StepperState.Inactive;
    }
  }

  void markAsCompletedForPrecedingSteps(int upTo) {
    for (int i = 0; i <= upTo; i++) {
      steps[i].state = StepperState.Active;
    }
  }

  @override
  void dispose() {
    widget.stepperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AppStep>>(
      stream: widget.stepperController.steps,
      initialData: [],
      builder: (context, snapshot) {
        steps = snapshot.data!;
        if (snapshot.data!.isEmpty || snapshot.data!.length == 0) {
          return Container();
        }
        return StreamBuilder<int?>(
          initialData: 0,
          stream: widget.stepperController.activeStep,
          builder: (context, snapshot) {
            double width = MediaQuery.of(context).size.width;
            int? validIndex = _isIndexValid(snapshot.data!)
                ? snapshot.data
                : _getValidIndex(snapshot.data!);
            changeStatus(validIndex!);
            return Container(
              width: width,
              padding: const EdgeInsets.only(
                top: PADDING_SMALL,
              ),
              child: Column(
                children: [
                  Container(
                    height: circleRadius + 5,
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _getStepperWidget(),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  _getLineWidget(constraints.maxWidth.toInt()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: textMargin),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _getTitleWidgets(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _getStepperWidget() {
    List<Widget> widgets = [];
    steps.asMap().forEach((key, value) {
      widgets.add(Expanded(
        child: _getStepWidget(value),
      ));
    });
    return widgets;
  }

  List<Widget> _getLineWidget(int rowWidth) {
    List<Widget> widgets = [];
    steps.asMap().forEach((key, value) {
      if (key == 0 || key == steps.length - 1) {
        widgets.add(SizedBox(width: rowWidth / (steps.length * 2)));
      }
      int lineMargin = 2;
      //Get horizontal line
      if (key != steps.length - 1) {
        widgets.add(
          SizedBox(width: circleRadius / 2 + lineMargin),
        );
        widgets.add(
          _getStepLineWithTopSpacing(steps[key + 1]),
        );
        widgets.add(
          SizedBox(width: circleRadius / 2 + lineMargin),
        );
      }
    });
    return widgets;
  }

  List<Widget> _getTitleWidgets() {
    List<Widget> widgets = [];
    steps.asMap().forEach((key, value) {
      widgets.add(
        Expanded(
          child: _getTextTitleWidget(value),
        ),
      );
    });
    return widgets;
  }

  _getStepWidget(AppStep step) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getStepCircle(step),
        SizedBox(height: textMargin),
        // _getTextTitleWidget(step, textAlign: TextAlign.center),
      ],
    );
  }

  _getTextTitleWidget(AppStep step, {TextAlign textAlign = TextAlign.center}) {
    return step.title != null
        ? Text(
            step.title!,
            maxLines: 1,
            textAlign: textAlign,
            overflow: TextOverflow.clip,
            style: _getModifiedTextStyle(step),
          )
        : Container();
  }

  _getStepCircle(AppStep step) {
    return InkWell(
      onTap: stepsClickable == true
          ? () {
              widget.stepperController.setActive(steps.indexOf(step));
            }
          : () {},
      child: StepCircle(
        step: step,
        circleRadius: circleRadius,
        selectedColor: selectedColor,
        unSelectedColor: unSelectedColor,
        selectedOuterCircleColor: selectedOuterCircleColor,
        circlePaddingFromBorder: circlePaddingFromBorder,
        unSelectedOuterCircleColor: unSelectedOuterCircleColor,
        selectedIconColor: selectedIconColor,
        unSelectedIconColor: unSelectedIconColor,
      ),
    );
  }

  TextStyle _getModifiedTextStyle(AppStep step) {
    if (textStyle != null) {
      Color color = step.state == StepperState.Active
          ? selectedTextColor
          : unSelectedTextColor;
      return textStyle.copyWith(color: color);
    }
    return body2regular;
  }

  _getStepLineWithTopSpacing(AppStep step) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: circleRadius / 2),
          StepLine(
            step,
            selectedLineColor,
            unSelectedLineColor,
          )
        ],
      ),
    );
  }

  bool isForward(int index) {
    return index > currentStep;
  }
}
