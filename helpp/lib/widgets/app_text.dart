import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppText extends StatelessWidget {
  String label; 
  String hint;
  bool password;
  TextEditingController controller;
  double sizeText;
  FormFieldValidator<String> validator; 
  TextInputType keyboardType;
  List<TextInputFormatter> inputFormatters;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  int maxLines;
  
  AppText(
    this.label, 
    this.hint, {
    this.password = false, 
    this.controller,
    this.sizeText, 
    this.validator, 
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.textInputAction, 
    this.focusNode, 
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if(nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF2196F3),
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32)
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: sizeText,
          color: Color(0xFF2196F3),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xFF2196F3),
        ),
      ),
    );
    return textFormField; 
  }
}
