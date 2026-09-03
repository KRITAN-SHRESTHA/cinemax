import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/style.dart' show textH5Regular, textH6Medium;
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: kLightBlue,
      style: textH5Regular.copyWith(color: kWhite),
      decoration: InputDecoration(
        labelText: label,
        //* Kept up on the border so the field reads as labelled even when it
        //* holds a value.
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: textH6Medium.copyWith(color: kWhiteGrey),
        hintText: hint,
        hintStyle: textH5Regular.copyWith(color: kDarkGrey),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        enabledBorder: _border(kDarkGrey.withValues(alpha: 0.5)),
        focusedBorder: _border(kBlueAccent.withValues(alpha: 0.5)),
        border: _border(kDarkGrey.withValues(alpha: 0.5)),
      ),
    );
  }
}
