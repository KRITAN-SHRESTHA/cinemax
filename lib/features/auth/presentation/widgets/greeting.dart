import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(kAvatarIcon, width: 40, height: 40),
        16.horizontalBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                kHomeGreeting,
                style: textH4SemiBold.copyWith(color: kWhite),
              ),
              4.verticalBox,
              Text(kHomeSubtitle, style: textH6Medium.copyWith(color: kGrey)),
            ],
          ),
        ),
        16.horizontalBox,
        GestureDetector(
          //* Nowhere to send them yet.
          onTap: () {},
          child: SvgPicture.asset(kWishListIcon, width: 32, height: 32),
        ),
      ],
    );
  }
}
