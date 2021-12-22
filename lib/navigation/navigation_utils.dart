import 'package:flutter/material.dart';

import '../screens/pin_common_screen.dart';

class NavigationUtils {

  static void moveToPinConfirmationScreen(BuildContext context, {required String title, required PinConfig pinConfig}) {
    _moveToScreen(context, PinProcessCommonScreen(title: title, pinConfig: pinConfig));
  }

  static void _moveToScreen(BuildContext _context, Widget _screenToMoveOn) {
    Navigator.push(
      _context,
      MaterialPageRoute<void>(
        builder: (context) => _screenToMoveOn,
      ),
    );
  }
}
