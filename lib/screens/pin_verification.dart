import '../utilities/dialog_utils.dart';
import 'package:flutter/cupertino.dart';

import '../pin_view/pin_view.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({required this.pinCount, Key? key}) : super(key: key);
  final int pinCount;

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  @override
  Widget build(BuildContext context) {
    return PinView(
      key: GlobalKey(),
      title: 'Enter your PIN',
      pinCount: widget.pinCount,
      onChange: (pin) {},
      onComplete: _verifyPin,
    );
  }

  void _verifyPin(String pin) {
    final _isValid = SharedPreferencesUtil.getInstance().verifyPin(pin);
    if (_isValid) {
      Navigator.of(context).restorablePush(DialogUtils.dialogBuilderPinVerificationSuccess);
    } else {
      Navigator.of(context).restorablePush(DialogUtils.dialogBuilderPinVerificationFailure);
    }

    _resetScreen();
  }

  void _resetScreen() {
    setState(() {});
  }
}
