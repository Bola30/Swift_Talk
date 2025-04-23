import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText; // Label for the text field
  final TextEditingController controller; // Controller for the text field
  final String? Function(String?)? validator; // Validator function
  final TextInputType keyboardType; // Input type (e.g., email, phone, etc.)
  final bool obscureText; // Whether to hide the text (for passwords)
  final IconData? prefixIcon; // IconData to show before text
  final Widget? suffixIcon; // Widget (e.g., IconButton) to show after text
  final int? maxLength; // Max length for the input field

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 22, color: Colors.black),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppInfo.kPrimaryColor2)
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppInfo.kPrimaryColor2, // Default border coAppInfo.kPrimaryColor2
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.pink, // Border color changes to pink on focus
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppInfo.kPrimaryColor2, // Border color rAppInfo.kPrimaryColor2 when enabled
          ),
        ),
        counterText: '', // Hides the character counter if maxLength is set
      ),
      validator: validator,
    );
  }
}