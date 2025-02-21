import 'package:flutter/material.dart';

class TextFormFieldWithCustomStyles extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Color fillColor;
  final Color textColor;
  final Color borderColor;
  final Color labelColor;
  final Color hintColor;
  final String? prefixImagePath; // Nullable prefix image path
  final String? suffixImagePath; // Nullable suffix image path
  final VoidCallback? onSuffixTap; // Action for suffix tap

  const TextFormFieldWithCustomStyles({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.fillColor = const Color(0xFF2C2F32),
    this.textColor = Colors.white,
    this.borderColor = Colors.grey,
    this.labelColor = Colors.white,
    this.hintColor = const Color(0x80FFFFFF),
    this.prefixImagePath, // Optional parameter for prefix
    this.suffixImagePath, // Optional parameter for suffix
    this.onSuffixTap, // Optional tap action for suffix icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: labelColor),
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: fillColor,
        prefixIcon: prefixImagePath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(prefixImagePath!, width: 20, height: 20),
              )
            : null, // Show prefix image if path is provided
        suffixIcon: suffixImagePath != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(suffixImagePath!, width: 20, height: 20),
                ),
              )
            : null, // Show suffix image if path is provided
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
      ),
      validator: validator,
      style: TextStyle(color: textColor),
    );
  }
}
