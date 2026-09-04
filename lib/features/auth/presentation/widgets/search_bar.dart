import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: 20.horizontal,
      decoration: BoxDecoration(
        color: kSoft,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            kSearchIcon,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(kGrey, BlendMode.srcIn),
          ),
          12.horizontalBox,
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: kLightBlue,
              style: textH6Medium.copyWith(color: kWhite),
              decoration: InputDecoration.collapsed(
                hintText: kSearchHint,
                hintStyle: textH5Medium.copyWith(color: kGrey),
              ),
            ),
          ),
          12.horizontalBox,
          Container(width: 1, height: 18, color: kGrey.withValues(alpha: 0.4)),
          12.horizontalBox,
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              kFilterIcon,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
