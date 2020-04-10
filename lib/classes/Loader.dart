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
              label: "Try Again",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context, double progress) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Center(
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 5,
              backgroundColor: kBlueButtonColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(kBlueButtonColor),
            ),
          ),
          backgroundColor: kCardBackground.withOpacity(0.1),
        );
      },
    );
  }
}
