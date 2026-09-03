import 'package:auto_route/auto_route.dart';
import 'package:cinemax/config/routes/routes.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_app_bar.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_button.dart';
import 'package:cinemax/features/auth/presentation/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = .new();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //* Scrolls once the keyboard is up rather than squashing the field.
        child: SingleChildScrollView(
          padding: 24.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalBox,
              //* No title on this one: the heading below carries it.
              BuildAppBar(onBack: () => context.router.pop()),
              48.verticalBox,
              Text(
                kResetPassword,
                textAlign: TextAlign.center,
                style: textH1SemiBold.copyWith(color: kWhite),
              ),
              8.verticalBox,
              Text(
                kResetPasswordSubtitle,
                textAlign: TextAlign.center,
                style: textH5Medium.copyWith(color: kWhiteGrey, height: 1.5),
              ),
              48.verticalBox,
              InputField(
                controller: _emailController,
                label: kEmailAddress,
                hint: kEmailHint,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              40.verticalBox,
              BuildButton(
                text: kNext,
                onPressed: () {
                  final String email = _emailController.text.trim();
                  if (email.isNotEmpty) {
                    context.router.push(VerificationRoute(email: email));
                  }
                },
              ),
              10.verticalBox,
            ],
          ),
        ),
      ),
    );
  }
}
