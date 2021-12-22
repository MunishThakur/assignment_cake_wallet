import '../utilities/dialog_utils.dart';
import 'package:flutter/cupertino.dart';

import '../pin_view/pin_view.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';

class PinSetup extends StatefulWidget {
  const PinSetup({required this.pinCount, Key? key}) : super(key: key);
  final int pinCount;

  @override
  State<PinSetup> createState() => _PinSetupState();
}

class _PinSetupState extends State<PinSetup> {
  String pinInitial = '';
  String pinConfirm = '';

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  Widget _buildMainView() {
    if (_isInitialPinSet) {
      return PinView(
        key: GlobalKey(),
        title: 'Re-enter your PIN',
        pinCount: widget.pinCount,
        onChange: (pin) {},
        onComplete: (pin) {
          pinConfirm = pin;
          _checkIfBothPinsValid();
        },
      );
    } else {
      return PinView(
        key: GlobalKey(),
        title: 'Create PIN',
        pinCount: widget.pinCount,
        onChange: (pin) {},
        onComplete: (pin) {
          setState(() {
            pinInitial = pin;
          });
        },
      );
    }
  }

  bool get _isInitialPinSet => pinInitial.isNotEmpty;

  Future<void> _checkIfBothPinsValid() async {
    if (pinInitial == pinConfirm) {
      SharedPreferencesUtil.getInstance().savePin(pinConfirm).then((value) {
        Navigator.of(context).restorablePush(DialogUtils.dialogBuilderPinSetupSuccess);
        _resetScreen();
      });
    } else {
      Navigator.of(context).restorablePush(DialogUtils.dialogBuilderPinSetupFailure);
    }
    _resetScreen();
  }

  void _resetScreen() {
    pinInitial = '';
    pinConfirm = '';
    setState(() {});
  }
}
