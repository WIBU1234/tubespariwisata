import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:quickalert/quickalert.dart';

class component{
  static snackBarSuccess(BuildContext context, String message){
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: message),
    );
  }

  static snackBarError(BuildContext context, String message){
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: message),
    );
  }

  static snackBarInfo(BuildContext context, String message){
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(message: message),
    );
  }

  static quickAlertSuccess(BuildContext context, String messageContent){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: messageContent,
    );
  }

  static quickAlertError(BuildContext context, String messageTitle, String messageContent){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: messageTitle,
      text: messageContent,
    );
  }

  static quickAlertWarning(BuildContext context, String meessageTitle, String messageContent){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: messageContent,
    );
  }
}