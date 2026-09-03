import 'package:auto_route/auto_route.dart';
import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_button.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();

  //* The password starts hidden, as the crossed out eye in the design shows.
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              _TopBar(text: kLogin, onBack: () => context.router.maybePop()),
              48.verticalBox,
              Text(
                kLoginGreeting,
                textAlign: TextAlign.center,
                style: textH2SemiBold.copyWith(color: kWhite),
              ),
              16.verticalBox,
              Text(
                kLoginSubtitle,
                textAlign: TextAlign.center,
                style: textH6Medium.copyWith(color: kWhiteGrey, height: 1.5),
              ),
              64.verticalBox,
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
              12.verticalBox,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  //* No password reset flow to hand off to yet.
                  onTap: () {},
                  child: Text(
                    kForgotPassword,
                    style: textH5Medium.copyWith(color: kLightBlue),
                  ),
                ),
              ),
              32.verticalBox,
              BuildButton(text: kLogin, onPressed: () {}),
              10.verticalBox,
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.text});

  final VoidCallback onBack;
  final String text;

  //* The asset already draws its own rounded square.
  static const double _backSize = 32;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(12),
          child: SvgPicture.asset(
            kBackIcon,
            width: _backSize,
            height: _backSize,
          ),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textH3SemiBold.copyWith(color: kWhite),
          ),
        ),
        //* Balances the back button so the title lands on the centre line.
        const SizedBox(width: _backSize),
      ],
    );
  }
}
