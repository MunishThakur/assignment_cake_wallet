import '../constant/app_color.dart';
import 'package:flutter/material.dart';

typedef KeyboardTapDigitCallback = void Function(int digit);
typedef KeyboardDeleteCallback = void Function();
typedef PinViewVisible = void Function(bool isVisible);

class NumericKeyboard extends StatefulWidget {
  const NumericKeyboard({
    required this.onKeyboardDigitTap,
    required this.onKeyboardDeleteTap,
    required this.onPinViewVisible,
    Key? key,
  }) : super(key: key);

  final KeyboardTapDigitCallback onKeyboardDigitTap;
  final KeyboardDeleteCallback onKeyboardDeleteTap;
  final PinViewVisible onPinViewVisible;

  @override
  State<StatefulWidget> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 100.0;

  bool _isUserInputPinVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _buildButtonBarDigitRow(value1: 1, value2: 2, value3: 3),
          _buildButtonBarDigitRow(value1: 4, value2: 5, value3: 6),
          _buildButtonBarDigitRow(value1: 7, value2: 8, value3: 9),
          _buildButtonBarLastRow(),
        ],
      ),
    );
  }

  Widget _buildButtonBarDigitRow({required int value1, required int value2, required int value3}) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _drawDigitButton(value1),
        _drawDigitButton(value2),
        _drawDigitButton(value3),
      ],
    );
  }

  Widget _buildButtonBarLastRow() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        /*SizedBox(
          width: height,
          height: height,
        ),*/
        _drawIconButton(onTap: _togglePinVisibility, icon: Icons.remove_red_eye, iconColor: _isUserInputPinVisible ? Colors.green : AppColor.grayDigitColor),
        _drawDigitButton(0),
        _drawIconButton(onTap: widget.onKeyboardDeleteTap, icon: Icons.backspace, iconColor: Colors.red.withOpacity(0.8)),
      ],
    );
  }

  Widget _drawIconButton({required Function() onTap, required IconData icon, required Color iconColor}) {
    return InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Container(width: height, height: height, alignment: Alignment.center, child: Icon(icon, color: iconColor,)));
  }

  Widget _drawDigitButton(int value) {
    return InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor: AppColor.grayDigitRippleBackground,
        onTap: () {
          widget.onKeyboardDigitTap(value);
        },
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.grayDigitDefaultBackground,
          ),
          child: Container(
            alignment: Alignment.center,
            width: height,
            height: height,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 26,
                color: AppColor.grayDigitColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  void _togglePinVisibility() {
    setState(() {
      _isUserInputPinVisible = !_isUserInputPinVisible;
      widget.onPinViewVisible(_isUserInputPinVisible);
    });
  }
}
