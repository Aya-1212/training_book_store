import 'package:flutter/material.dart';

pushWithReplacement(context, Widget nextScreen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => nextScreen,
  ));
}

push(context, Widget nextScreen) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => nextScreen,
  ));
}

pushAndRemoveUntil(context, Widget nextScreen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false);
}

pop(context) {
  Navigator.of(context).pop(context);
}
