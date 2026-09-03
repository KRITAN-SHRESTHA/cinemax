import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key, required this.onBack, this.text = ''});

  //* Optional: some screens show the back button on its own.
  final String text;
  final VoidCallback onBack;

  //* The asset already draws its own rounded square.
  static const double _backSize = 32;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(12),
          child: SvgPicture.asset(
            kBackIcon,
            width: _backSize,
            height: _backSize,
          ),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textH3SemiBold.copyWith(color: kWhite),
          ),
        ),
        //* Balances the back button so the title lands on the centre line.
        const SizedBox(width: _backSize),
      ],
    );
  }
}
