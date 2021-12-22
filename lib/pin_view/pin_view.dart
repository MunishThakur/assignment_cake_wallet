import '../constant/app_color.dart';

import '../extensions/string_extensions.dart';
import '../keyboard/numeric_keyboard.dart';
import 'package:flutter/material.dart';

typedef OnChange = void Function(String pin);
typedef OnComplete = void Function(String pin);

class PinView extends StatefulWidget {
  const PinView({
    required this.onChange,
    required this.onComplete,
    this.pinCount = 4,
    this.title = '',
    Key? key,
  }) : super(key: key);

  final int pinCount;
  final String title;
  final OnChange onChange;
  final OnComplete onComplete;

  @override
  _PinViewState createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  String _pin = '';
  bool _isUserInputPinVisible = false;

  @override
  void didUpdateWidget(covariant PinView oldWidget) {
    super.didUpdateWidget(oldWidget);
    //_pin = _pin.lastChars(widget.pinCount);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.title.isNotEmpty)
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 24, color: AppColor.grayDigitColor),
                ),

              if (widget.title.isNotEmpty)
                const SizedBox(height: 16.0,),

              _pinView()
            ],
          )),
          NumericKeyboard(
            onKeyboardDigitTap: (digit) {
              addDigit(digit);
            },
            onKeyboardDeleteTap: () => removeDigit(),
            onPinViewVisible: (isVisible) {
              setState(() {
                _isUserInputPinVisible = isVisible;
              });
            },
          ),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Widget _pinView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: Iterable.generate(widget.pinCount, (digit) => _getPinView(digit: digit)).toList(),
    );
  }

  Widget _getPinView({required int digit}) {
    final isFilled = digit < _pin.length;

    Widget _pinViewWidget = Container();
    if (_isUserInputPinVisible && isFilled) {
      _pinViewWidget = Text(
        _pin[digit],
        style: const TextStyle(fontSize: 11),
      );
    } else {
      _pinViewWidget = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFilled ? AppColor.pinViewFilled : AppColor.pinViewEmpty,
          border: Border.all(
            color: isFilled ? Colors.transparent : AppColor.grayChateau,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 12,
      width: 12,
      child: _pinViewWidget,
    );
  }

  void addDigit(int digit) {
    setState(() {
      if (_pin.length == widget.pinCount) {
        return;
      }

      _pin += digit.toString();
      if (_pin.length == widget.pinCount) {
        widget.onComplete(_pin);
      } else {
        widget.onChange(_pin);
      }
    });
  }

  void removeDigit() {
    setState(() {
      _pin = _pin.removeChar();
    });
  }
}
