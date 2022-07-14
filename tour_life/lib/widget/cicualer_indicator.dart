import 'package:flutter/material.dart';
import 'package:tour_life/constant/colorses.dart';

import '../constant/strings.dart';

Future<void> showLoader({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: Colorses.red,
        ),
      );
    },
  );
}

void hideLoader({
  required BuildContext context,
}) {
  Navigator.of(context).pop();
}
