import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    Key key,
    @required this.child,
    @required this.color,
    @required this.onPressed,
    this.disabledColor,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final Color disabledColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      child: child,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      onPressed: onPressed,
      disabledColor: disabledColor,
    );
  }
}
