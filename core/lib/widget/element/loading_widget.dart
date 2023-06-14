import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget showLoading(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: const Color(0x30000000),
    child: const Center(
      child: SpinKitCircle(
        size: 50,
        color: Color(0xff58a3a5),
      ),
    ),
  );
}