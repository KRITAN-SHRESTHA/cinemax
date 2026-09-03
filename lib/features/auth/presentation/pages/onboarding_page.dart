import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/features/auth/presentation/widgets/onboarding_bottom_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class _OnboardingItem {
  const _OnboardingItem({required this.copy, this.artwork, this.backdrop});

  final OnboardingCopy copy;

  //* Cut out shown in the free space above the card.
  final String? artwork;

  //* Poster wall painted behind the whole screen instead of an artwork.
  final String? backdrop;
}

//* Single source of truth for the flow: the page count, the artwork and the
//* copy all come from here, so the dots and the progress ring follow along.
const List<_OnboardingItem> _items = [
  _OnboardingItem(
    copy: (title: kOnboardingTitle1, description: kOnboardingDesc1),
    backdrop: kOnboarding1,
  ),
  _OnboardingItem(
    copy: (title: kOnboardingTitle2, description: kOnboardingDesc2),
    artwork: kOnboarding2,
  ),
  _OnboardingItem(
    copy: (title: kOnboardingTitle3, description: kOnboardingDesc3),
    artwork: kOnboarding3,
  ),
];

final List<OnboardingCopy> _copy = [
  for (final _OnboardingItem item in _items) item.copy,
];

//* The card carries the copy, so the package's own title and body stay empty
//* and the artwork gets the top of the screen.
const PageDecoration _pageDecoration = PageDecoration(
  boxDecoration: BoxDecoration(),
  titlePadding: EdgeInsets.zero,
  bodyPadding: EdgeInsets.zero,
  contentMargin: EdgeInsets.zero,
  imagePadding: EdgeInsets.only(top: 40, left: 24, right: 24),
  imageFlex: 3,
  bodyFlex: 2,
);

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  PageController? _controller;

  @override
  void initState() {
    super.initState();
    //* IntroductionScreen builds the PageController itself, so it can only be
    //* picked up after the first frame. The card needs it to follow the swipe.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _controller = introKey.currentState?.controller);
    });
  }

  //* Fractional while a swipe is in flight, which is what makes the copy and
  //* the ring move with the finger rather than snap on page change.
  double get _pageOffset {
    final PageController? controller = _controller;
    if (controller == null ||
        !controller.hasClients ||
        !controller.position.haveDimensions) {
      return introKey.currentState?.getCurrentPage().toDouble() ?? 0;
    }
    return controller.page ?? 0;
  }

  //* animateScroll clamps to the last page, so this is a no-op at the end of
  //* the flow. Send the user onwards from here once there is a screen to go to.
  void _onNext() => introKey.currentState?.next();

  //* Stacked over the pages, so a page has either a backdrop or an artwork:
  //* with a backdrop the image slot holds the scrim that dims it.
  PageViewModel _buildPage(_OnboardingItem item) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: const SizedBox.shrink(),
    backgroundImage: item.backdrop,
    image: item.backdrop != null
        ? Positioned.fill(
            child: ColoredBox(color: kDark.withValues(alpha: 0.55)),
          )
        : Image.asset(item.artwork!, fit: BoxFit.contain),
    decoration: _pageDecoration,
  );

  //* Rebuilt on every scroll tick so the card tracks the drag. Until the
  //* controller arrives there is nothing to listen to.
  Widget _buildCard() {
    Widget card() =>
        OnboardingBottomCard(pages: _copy, page: _pageOffset, onNext: _onNext);

    final PageController? controller = _controller;
    if (controller == null) return card();

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => card(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kSoft,
      curve: Curves.easeInOut,
      pages: [for (final _OnboardingItem item in _items) _buildPage(item)],
      //* The card draws the dots and the next button, so the package's own
      //* controls are switched off and take up no room.
      showSkipButton: false,
      showNextButton: false,
      showDoneButton: false,
      isProgress: false,
      controlsMargin: EdgeInsets.zero,
      controlsPadding: EdgeInsets.zero,
      //* globalFooter sits outside the page view, which is what keeps the card
      //* still while the artwork behind it slides.
      globalFooter: _SwipeArea(
        controller: _controller,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: _buildCard(),
          ),
        ),
      ),
    );
  }
}

//* The card covers the bottom of the page view and would swallow drags, so
//* they are handed back to the page scroll position.
class _SwipeArea extends StatefulWidget {
  const _SwipeArea({required this.controller, required this.child});

  final PageController? controller;
  final Widget child;

  @override
  State<_SwipeArea> createState() => _SwipeAreaState();
}

class _SwipeAreaState extends State<_SwipeArea> {
  Drag? _drag;

  ScrollPosition? get _position {
    final PageController? controller = widget.controller;
    return controller != null && controller.hasClients
        ? controller.position
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _drag = _position?.drag(details, () => _drag = null);
      },
      onHorizontalDragUpdate: (details) => _drag?.update(details),
      onHorizontalDragEnd: (details) => _drag?.end(details),
      onHorizontalDragCancel: () => _drag?.cancel(),
      child: widget.child,
    );
  }
}
