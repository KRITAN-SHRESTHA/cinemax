import 'package:auto_route/auto_route.dart';
import 'package:cinemax/config/routes/routes.dart';
import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        SearchRoute(),
        DownloadRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: DecoratedBox(
            decoration: const BoxDecoration(color: kDark),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int index = 0; index < _tabs.length; index++)
                      _NavItem(
                        tab: _tabs[index],
                        selected: tabsRouter.activeIndex == index,
                        onTap: () => tabsRouter.setActiveIndex(index),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef _Tab = ({String asset, String label});

//* Order matches the routes above.
const List<_Tab> _tabs = [
  (asset: kHomeIcon, label: kHomeLabel),
  (asset: kSearchIcon, label: kSearchLabel),
  (asset: kDownloadIcon, label: kDownloadLabel),
  (asset: kProfileIcon, label: kProfileLabel),
];

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final _Tab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      //* A single 0 -> 1 value drives the pill, the colours and the label, so
      //* they cannot drift out of step with each other.
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(end: selected ? 1 : 0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        builder: (context, progress, child) {
          final Color color = Color.lerp(kDarkGrey, kLightBlue, progress)!;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12 + 4 * progress,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              //* Only the active tab sits on a pill.
              color: Color.lerp(Colors.transparent, kSoft, progress),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  tab.asset,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                //* The label unrolls from behind the icon instead of popping
                //* in: widthFactor 0 gives it no width at all. heightFactor
                //* must be set too, or the Align fills the tallest height the
                //* Scaffold offers and stretches the whole bar.
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    heightFactor: 1,
                    child: Opacity(
                      opacity: progress,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          tab.label,
                          style: textH6Medium.copyWith(color: color),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
