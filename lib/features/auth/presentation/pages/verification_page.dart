import 'package:auto_route/auto_route.dart';
import 'package:cinemax/config/routes/routes.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_app_bar.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.email});

  //* The address the code was sent to, handed over by the previous screen.
  final String email;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _codeController = .new();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //* Scrolls once the keyboard is up rather than squashing the boxes.
        child: SingleChildScrollView(
          padding: 24.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalBox,
              //* No title on this one: the heading below carries it.
              BuildAppBar(onBack: () => context.router.maybePop()),
              48.verticalBox,
              Text(
                kVerifyTitle,
                textAlign: TextAlign.center,
                style: textH2SemiBold.copyWith(color: kWhite),
              ),
              16.verticalBox,
              Text.rich(
                TextSpan(
                  text: kVerifySubtitle,
                  style: textH5Medium.copyWith(color: kGrey, height: 1.5),
                  children: [
                    //* The address itself is picked out of the sentence.
                    TextSpan(
                      text: widget.email,
                      style: textH5SemiBold.copyWith(
                        color: kWhite,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              32.verticalBox,
              _CodeInput(controller: _codeController),
              56.verticalBox,
              BuildButton(
                text: kContinueText,
                onPressed: () {
                  context.router.push(const CreateNewPasswordRoute());
                },
              ),
              40.verticalBox,
              _ResendPrompt(onPressed: () {}),
              10.verticalBox,
            ],
          ),
        ),
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  const _CodeInput({required this.controller});

  final TextEditingController controller;

  static const double _boxSize = 62;

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultTheme = PinTheme(
      width: _boxSize,
      height: _boxSize,
      textStyle: textH2SemiBold.copyWith(color: kWhite),
      decoration: BoxDecoration(
        color: kSoft,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    //* A box picks up the accent border once it is being typed in, and keeps
    //* it once it holds a digit.
    final PinTheme activeTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: kLightBlue, width: 1.5),
      ),
    );

    return Pinput(
      length: 4,
      controller: controller,
      defaultPinTheme: defaultTheme,
      focusedPinTheme: activeTheme,
      submittedPinTheme: activeTheme,
      cursor: const SizedBox.shrink(),
      separatorBuilder: (index) => const SizedBox(width: 16),
      onCompleted: (code) {},
    );
  }
}

class _ResendPrompt extends StatelessWidget {
  const _ResendPrompt({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //* Wraps rather than overflows when the line does not fit.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(kDidntReceiveCode, style: textH5Medium.copyWith(color: kGrey)),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            kResend,
            style: textH5SemiBold.copyWith(color: kBlueAccent),
          ),
        ),
      ],
    );
  }
}
