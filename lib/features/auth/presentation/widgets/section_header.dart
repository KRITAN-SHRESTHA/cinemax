import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textH4SemiBold.copyWith(color: kWhite)),
        GestureDetector(
          //* No catalogue screen to open yet.
          onTap: () {},
          child: Text(kSeeAll, style: textH5Medium.copyWith(color: kLightBlue)),
        ),
      ],
    );
  }
}
