import 'package:flutter/material.dart';
import 'package:brew_crew/widgets/error_dialog.dart';
import 'package:brew_crew/widgets/loading_dialog.dart';
import 'package:brew_crew/widgets/success_dialog.dart';

void loadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LoadingDialog();
      });
}

void successDialog(BuildContext context, String txt) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SuccessDialog(txt);
      });
}

void errorDialog(BuildContext context, String txt) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ErrorDialog(txt);
      });
}
