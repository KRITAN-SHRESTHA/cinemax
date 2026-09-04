import 'package:auto_route/auto_route.dart';
import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = .new();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: 24.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            16.verticalBox,
            const _Greeting(),
            24.verticalBox,
            _SearchBar(controller: _searchController),
          ],
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(kAvatarIcon, width: 40, height: 40),
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

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

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
