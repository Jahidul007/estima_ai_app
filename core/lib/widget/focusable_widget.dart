import 'package:flutter/material.dart';

class FocusableWidget extends StatelessWidget {
  final Stream<bool> focusStream;
  final Widget widget;
  final GlobalKey dataKey;
  final String name;

  const FocusableWidget(this.focusStream, this.widget, this.dataKey, this.name,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: focusStream,
      key: dataKey,
      builder: (context, snapshot) {
        bool isFocused =
            snapshot.hasData && snapshot.data != null && snapshot.data == true;
        if (isFocused) {
          Scrollable.ensureVisible(dataKey.currentContext!);
        }
        return widget;
      },
    );
  }
}


