import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final TextInputAction? textInputAction;
  final String? Function(String? val) validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.validator,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
    );
  }
}
