import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'pin_setup.dart';
import 'pin_verification.dart';

class PinProcessCommonScreen extends StatefulWidget {
  const PinProcessCommonScreen({required this.title, required this.pinConfig, Key? key}) : super(key: key);

  final String title;
  final PinConfig pinConfig;

  @override
  State<PinProcessCommonScreen> createState() => _PinProcessCommonScreenState();
}

class _PinProcessCommonScreenState extends State<PinProcessCommonScreen> {
  static const int _pinCountDefault = 4;
  int _pinCount = _pinCountDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  _togglePinCount();
                },
                child: Text(
                  'Use ${_getTogglePinValue()} Digit pin',
                  style: const TextStyle(color: AppColor.grayDigitColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: _getMainWidgetView(),
    );
  }
  
  Widget _getMainWidgetView() {
    switch(widget.pinConfig) {
      case PinConfig.SET_PIN:
        return PinSetup(pinCount: _pinCount,);
      case PinConfig.VERIFY_PIN:
        return PinVerification(pinCount: _pinCount,);
    }
  }

  void _togglePinCount() {
    setState(() {
      _pinCount = _getTogglePinValue();
    });
  }

  bool _isDefaultDigitPin() => _pinCount == _pinCountDefault;

  int _getTogglePinValue() => _isDefaultDigitPin() ? 6 : _pinCountDefault;
}

enum PinConfig { SET_PIN, VERIFY_PIN }
