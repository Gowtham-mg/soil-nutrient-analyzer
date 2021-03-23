import 'package:flutter/material.dart';

const Color defaultColorLoginInputField = Color(0xFFE7EAEE);

class LoginRegisterTextFormField extends StatelessWidget {
  const LoginRegisterTextFormField({
    Key key,
    @required this.hintText,
    @required this.validator,
    @required this.onSaved,
    this.color = defaultColorLoginInputField,
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final Function(String) validator;
  final Function(String) onSaved;
  final Color color;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: validator,
        initialValue: initialValue,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF959595),
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          filled: true,
          fillColor: color,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            borderSide: BorderSide.none,
          ),
          enabled: true,
          contentPadding: EdgeInsets.only(left: 22),
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
