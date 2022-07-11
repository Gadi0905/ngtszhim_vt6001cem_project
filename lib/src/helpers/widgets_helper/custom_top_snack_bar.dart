import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomTopSnackBar {
  static showError({@required context, @required errorMessage}) {
    showTopSnackBar(context, CustomSnackBar.error(message: errorMessage));
  }

  static showInfo({@required context, @required message}) {
    showTopSnackBar(context, CustomSnackBar.info(message: message));
  }
}
