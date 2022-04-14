import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopSnackBar {
  // show error top snack bar
  static showError({@required context, @required errorMessage}) {
    showTopSnackBar(context, CustomSnackBar.error(message: errorMessage));
  }

  // show information top snack bar
  static showInfo({@required context, @required message}) {
    showTopSnackBar(context, CustomSnackBar.info(message: message));
  }
}
