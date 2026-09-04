import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OverflowBox(
        maxWidth: MediaQuery.sizeOf(context).width,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: 24.horizontal,
          itemCount: categories.length,
          separatorBuilder: (context, index) => 8.horizontalBox,
          itemBuilder: (context, index) {
            final bool isSelected = index == selected;

            return GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? kSoft : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  categories[index],
                  style: textH6Medium.copyWith(
                    color: isSelected ? kLightBlue : kWhite,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
