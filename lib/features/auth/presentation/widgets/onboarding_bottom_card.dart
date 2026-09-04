import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

typedef OnboardingCopy = ({String title, String description});

//* Card pinned to the bottom of the onboarding flow. It holds still while the
//* pages move: only the copy inside slides, driven by [page].
class OnboardingBottomCard extends StatelessWidget {
  const OnboardingBottomCard({
    super.key,
    required this.pages,
    required this.page,
    required this.onNext,
  });

  final List<OnboardingCopy> pages;

  //* Live PageView offset. Fractional mid swipe, so the copy and the ring
  //* follow the finger instead of snapping when the page changes.
  final double page;

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);

    //* Short screens get tighter spacing so the card still clears the artwork.
    final bool isCompact = screen.height < 640;

    return Container(
      width: screen.width / 1.3,
      padding: EdgeInsets.fromLTRB(
        30,
        isCompact ? 22 : 30,
        24,
        isCompact ? 24 : 32,
      ),
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlidingCopy(pages: pages, page: page),
          (isCompact ? 24 : 40).verticalBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageIndicator(itemCount: pages.length, page: page),
              NextButton(
                onTap: onNext,
                segments: pages.length,
                progress: (page + 1) / pages.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//* Every page's copy stacked in one spot and shifted by the page offset, so
//* the title and description slide along with the artwork behind them.
class SlidingCopy extends StatelessWidget {
  const SlidingCopy({super.key, required this.pages, required this.page});

  final List<OnboardingCopy> pages;
  final double page;

  @override
  Widget build(BuildContext context) {
    final int currentIndex = page.round().clamp(0, pages.length - 1);

    return ClipRect(
      child: Stack(
        children: [
          for (int index = 0; index < pages.length; index++)
            //* Each block is one card wide, so index - page is its shift.
            FractionalTranslation(
              translation: Offset(index - page, 0),
              child: ExcludeSemantics(
                //* Only the page on screen should be read out.
                excluding: index != currentIndex,
                child: _Copy(copy: pages[index]),
              ),
            ),
        ],
      ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({required this.copy});

  final OnboardingCopy copy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            copy.title,
            textAlign: TextAlign.center,
            style: textH3SemiBold.copyWith(color: kWhite, height: 1.4),
          ),
          16.verticalBox,
          Text(
            copy.description,
            textAlign: TextAlign.center,
            style: textH5Medium.copyWith(
              color: kGrey,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
    required this.progress,
    required this.segments,
  });

  final VoidCallback onTap;

  //* How much of the ring is filled in: one page read equals one arc.
  final double progress;

  //* One arc per page, so the ring closes on the last one.
  final int segments;

  static const double _buttonSize = 56;

  //* Space between the button and the ring drawn around it.
  static const double _gap = 8;
  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _buttonSize + _gap * 2,
      child: CustomPaint(
        painter: ProgressRingPainter(
          progress: progress,
          segments: segments,
          color: kBlueAccent,
          radius: _radius + _gap,
        ),
        child: Center(
          child: SizedBox.square(
            dimension: _buttonSize,
            child: Material(
              color: kBlueAccent,
              borderRadius: BorderRadius.circular(_radius),
              child: InkWell(
                borderRadius: BorderRadius.circular(_radius),
                onTap: onTap,
                child: const Icon(Icons.chevron_right, color: kDark, size: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//* Rounded square around the next button, drawn as one arc per page with a
//* gap between them, filling clockwise from the top centre as pages advance.
class ProgressRingPainter extends CustomPainter {
  const ProgressRingPainter({
    required this.progress,
    required this.segments,
    required this.color,
    required this.radius,
  });

  final double progress;
  final int segments;
  final Color color;
  final double radius;

  static const double strokeWidth = 2;

  //* Breathing room left between one page's arc and the next.
  static const double _gapLength = 6;

  //* Starts at the top centre and runs clockwise, so the arcs fill in the same
  //* order the pages advance.
  Path _ringPath(Size size) {
    final double inset = strokeWidth / 2;
    final double right = size.width - inset;
    final double bottom = size.height - inset;
    final double middle = size.width / 2;
    final Radius corner = Radius.circular(radius);

    return Path()
      ..moveTo(middle, inset)
      ..lineTo(right - radius, inset)
      ..arcToPoint(Offset(right, inset + radius), radius: corner)
      ..lineTo(right, bottom - radius)
      ..arcToPoint(Offset(right - radius, bottom), radius: corner)
      ..lineTo(inset + radius, bottom)
      ..arcToPoint(Offset(inset, bottom - radius), radius: corner)
      ..lineTo(inset, inset + radius)
      ..arcToPoint(Offset(inset + radius, inset), radius: corner)
      ..lineTo(middle, inset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || segments <= 0) return;

    final ring = _ringPath(size).computeMetrics().first;
    final double filled = ring.length * progress.clamp(0.0, 1.0);
    final double slice = ring.length / segments;

    final Path arcs = Path();
    for (int index = 0; index < segments; index++) {
      final double start = index * slice + _gapLength / 2;
      final double limit = (index + 1) * slice - _gapLength / 2;

      //* An arc in progress stops at the fill point, a finished one stops
      //* short of the next arc to leave the gap.
      final double end = filled < limit ? filled : limit;
      if (end > start) {
        arcs.addPath(ring.extractPath(start, end), Offset.zero);
      }
    }

    canvas.drawPath(
      arcs,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.segments != segments ||
      oldDelegate.color != color ||
      oldDelegate.radius != radius;
}
