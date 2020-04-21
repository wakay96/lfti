import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_dialog_button.dart";

class Loader {
  void showAlertDialog(String label, String sub, BuildContext context) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          content: Text(sub),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          backgroundColor: kCardBackground,
          actions: <Widget>[
            CustomDialogButton(
              label: "Retry",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 6.0,
            backgroundColor: kCardBackground,
            valueColor: AlwaysStoppedAnimation<Color>(kBlueButtonColor),
          ),
        );
      },
    );
  }

  void dismissDialog(context) {
    Navigator.pop(context);
  }
}
