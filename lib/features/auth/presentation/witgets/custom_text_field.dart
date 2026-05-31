import 'package:flutter/material.dart';

class CustomFieldText extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  const CustomFieldText({
   super.key,
    required this.labelText,
    this.obscureText = false,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: TextField(
       obscureText: obscureText,
       decoration: InputDecoration(
         labelText: labelText,
         border: const OutlineInputBorder(),
         focusedBorder: const OutlineInputBorder(
           borderSide: BorderSide(color: Colors.blue, width: 2.0),
         )
       )
      ),
    );
  }

}