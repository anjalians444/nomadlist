import 'dart:core';

import 'package:flutter/material.dart';

class CustomLinearProgressbar extends StatelessWidget {
  double? value;
    //  Color? backgroundColor;
  Color? color;
  // Color? valueColor;
  // double? minHeight;
  //     String? semanticsLabel;
  // String? semanticsValue;
  // this.valueColor,this.minHeight,this.semanticsLabel,this.semanticsValue
   CustomLinearProgressbar({Key? key,this.value,this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        value: value,
        color: color,
        // minHeight: minHeight,
        // semanticsLabel: semanticsLabel,
        //   semanticsValue: semanticsValue,
        backgroundColor: Colors.green[100],
      ) ,
    );
  }
}
