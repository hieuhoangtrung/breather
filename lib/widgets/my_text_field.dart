import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  final OnChangedCallback onChanged;
  final String initialValue;
  MyTextField(
      {this.label,
      this.maxLines = 1,
      this.minLines = 1,
      this.icon,
      this.initialValue,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: TextEditingController()..text = initialValue,
      onChanged: this.onChanged,
      style: TextStyle(
          color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 24.0),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null : icon,
          // labelText: label,
          labelStyle: TextStyle(color: Colors.black45),
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.black26,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}

typedef OnChangedCallback = void Function(String text);
