import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key, this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kLightBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: 32.rounded),
        ),
        //* No auth flow to hand off to yet.
        onPressed: onPressed,
        child: Text(text, style: textH4Medium.copyWith(color: kWhite)),
      ),
    );
  }
}
