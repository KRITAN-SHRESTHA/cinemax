import 'package:auto_route/auto_route.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_app_bar.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_button.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = .new();
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();

  //* The password starts hidden, as the crossed out eye in the design shows.
  bool _obscurePassword = true;
  bool _agreedToTerms = false;

  //* Held as fields rather than built inline so they can be disposed.
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    //* Nothing to open yet: the documents are not in the app.
    _termsRecognizer = TapGestureRecognizer()..onTap = () {};
    _privacyRecognizer = TapGestureRecognizer()..onTap = () {};
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //* Scrolls once the keyboard is up rather than squashing the fields.
        child: SingleChildScrollView(
          padding: 24.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalBox,
              BuildAppBar(
                text: kSignUp,
                onBack: () => context.router.maybePop(),
              ),
              48.verticalBox,
              Text(
                kSignUpGreeting,
                textAlign: TextAlign.center,
                style: textH2SemiBold.copyWith(color: kWhite),
              ),
              16.verticalBox,
              Text(
                kSignUpTagline,
                textAlign: TextAlign.center,
                style: textH6Medium.copyWith(color: kWhiteGrey, height: 1.5),
              ),
              64.verticalBox,
              InputField(
                controller: _nameController,
                label: kFullName,
                hint: kFullNameHint,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              24.verticalBox,
              InputField(
                controller: _emailController,
                label: kEmailAddress,
                hint: kEmailHint,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              24.verticalBox,
              InputField(
                controller: _passwordController,
                label: kPassword,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_outlined,
                    color: kDarkGrey,
                  ),
                ),
              ),
              20.verticalBox,
              _TermsCheck(
                value: _agreedToTerms,
                onChanged: (value) => setState(() => _agreedToTerms = value),
                termsRecognizer: _termsRecognizer,
                privacyRecognizer: _privacyRecognizer,
              ),
              32.verticalBox,
              BuildButton(text: kSignUp, onPressed: () {}),
              10.verticalBox,
            ],
          ),
        ),
      ),
    );
  }
}

class _TermsCheck extends StatelessWidget {
  const _TermsCheck({
    required this.value,
    required this.onChanged,
    required this.termsRecognizer,
    required this.privacyRecognizer,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final TapGestureRecognizer termsRecognizer;
  final TapGestureRecognizer privacyRecognizer;

  @override
  Widget build(BuildContext context) {
    final TextStyle linkStyle = textH6Medium.copyWith(color: kLightBlue);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.square(
          dimension: 24,
          child: Checkbox(
            value: value,
            onChanged: (checked) => onChanged(checked ?? false),
            activeColor: kLightBlue,
            checkColor: kWhite,
            side: const BorderSide(color: kDarkGrey, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            //* Keeps the box at the size the design draws it.
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        12.horizontalBox,
        Expanded(
          child: Text.rich(
            TextSpan(
              text: kAgreeTo,
              style: textH6Medium.copyWith(color: kGrey, height: 1.5),
              children: [
                TextSpan(
                  text: kTermsAndServices,
                  style: linkStyle,
                  recognizer: termsRecognizer,
                ),
                TextSpan(text: kAnd),
                TextSpan(
                  text: kPrivacyPolicy,
                  style: linkStyle,
                  recognizer: privacyRecognizer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
