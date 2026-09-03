import 'package:auto_route/auto_route.dart';
import 'package:cinemax/config/routes/routes.dart';
import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LoginSignUPPage extends StatelessWidget {
  const LoginSignUPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //* Centred on a roomy screen, scrollable once the keyboard or a small
        //* screen leaves less room than the content needs.
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: 24.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(kSplashIcon, width: 138, height: 138),
                    24.verticalBox,
                    Text(
                      kSignUpSubtitle,
                      textAlign: TextAlign.center,
                      style: textH5SemiBold.copyWith(color: kGrey, height: 1.5),
                    ),
                    64.verticalBox,
                    BuildButton(
                      text: kSignUp,
                      onPressed: () {
                        context.router.push(const SignUpRoute());
                      },
                    ),
                    20.verticalBox,
                    _LoginPrompt(
                      onPressed: () {
                        context.router.push(const LoginRoute());
                      },
                    ),
                    32.verticalBox,
                    const _OrDivider(),
                    40.verticalBox,
                    const _SocialRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    //* Wraps rather than overflows when the line does not fit.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(kAlreadyHaveAccount, style: textH4Medium.copyWith(color: kGrey)),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            kLogin,
            style: textH4SemiBold.copyWith(color: kBlueAccent),
          ),
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final Widget line = Expanded(
      child: Divider(color: kDarkGrey.withValues(alpha: 0.3), height: 1),
    );

    //* Sits inside the button's width, matching the design.
    return Padding(
      padding: 36.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            line,
            //* Natural width on a roomy screen, capped so a long label or a
            //* large text scale wraps instead of overflowing the row.
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.7),
              child: Text(
                kOrSignUpWith,
                textAlign: TextAlign.center,
                style: textH5Medium.copyWith(color: kGrey),
              ).px(12),
            ),
            line,
          ],
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 24,
      children: [
        _SocialButton(icon: kGoogleIcon, onPressed: () {}),
        _SocialButton(icon: kAppleIcon, onPressed: () {}),
        _SocialButton(icon: kFacebookIcon, onPressed: () {}),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, this.onPressed});

  //* Each asset already carries its own coloured circle.
  final String icon;

  static const double _size = 69;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: SvgPicture.asset(icon, width: _size, height: _size),
    );
  }
}
