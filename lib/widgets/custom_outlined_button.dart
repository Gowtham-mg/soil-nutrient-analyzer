import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.elevation,
    @required this.color,
  }) : super(key: key);
  final Widget child;
  final Function onPressed;
  final double elevation;
  final Color color;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      child: child,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        side: BorderSide(
          color: color,
          width: 2.5,
        ),
      ),
      elevation: elevation,
      padding: EdgeInsets.symmetric(vertical: 10),
      onPressed: onPressed,
    );
  }
}
