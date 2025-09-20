import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const InputFormField({
    required this.label,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }
}
