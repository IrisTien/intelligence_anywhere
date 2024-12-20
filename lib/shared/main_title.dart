import 'package:flutter/material.dart';

class IntelTitle extends StatelessWidget {
  const IntelTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: TextStyle(fontSize: 28), children: [
        TextSpan(
            text: 'Workspace ONE ', style: TextStyle(color: Colors.grey[350])),
        TextSpan(
            text: 'Intelligence',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
      ]),
    );
  }
}
