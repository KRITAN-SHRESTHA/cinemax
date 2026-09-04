import 'package:cinemax/core/utils/color.dart';
import 'package:flutter/material.dart';

//* Row of dots where the current one stretches into a pill. Shared by the
//* onboarding card and the home carousel.
class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.itemCount, required this.page});

  final int itemCount;

  //* Live page offset: the dot switches at the halfway point.
  final double page;

  @override
  Widget build(BuildContext context) {
    final int currentIndex = page.round().clamp(0, itemCount - 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        ...List.generate(itemCount, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: index == currentIndex ? 24 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: kLightBlue.withValues(
                alpha: index == currentIndex ? 1 : 0.4,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ],
    );
  }
}
