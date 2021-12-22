import 'package:flutter/cupertino.dart';

class DialogUtils {

  static Route<Object?> dialogBuilderPinSetupSuccess(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Your PIN has been setup Successfully!'),
          actions: <Widget>[
            CupertinoDialogAction(child: const Text('Ok'), onPressed: () {
              Navigator.pop(context);
            },),
          ],
        );
      },
    );
  }

  static Route<Object?> dialogBuilderPinSetupFailure(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Pin does not match, Please try again!'),
          actions: <Widget>[
            CupertinoDialogAction(child: const Text('Oops..'), onPressed: () {
              Navigator.pop(context);
            },),
          ],
        );
      },
    );
  }

  static Route<Object?> dialogBuilderPinVerificationSuccess(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text('Authentication Success'),
        );
      },
    );
  }

  static Route<Object?> dialogBuilderPinVerificationFailure(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text('Authentication Failed'),
        );
      },
    );
  }
}
