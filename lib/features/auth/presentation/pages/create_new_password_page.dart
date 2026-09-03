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
class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController _passwordController = .new();
  final TextEditingController _confirmController = .new();

  //* Both fields start hidden, and each eye is toggled on its own.
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
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
              //* No title on this one: the heading below carries it.
              BuildAppBar(onBack: () => context.router.pop()),
              48.verticalBox,
              Text(
                kCreateNewPassword,
                textAlign: TextAlign.center,
                style: textH2SemiBold.copyWith(color: kWhite),
              ),
              8.verticalBox,
              Text(
                kCreateNewPasswordSubtitle,
                textAlign: TextAlign.center,
                style: textH5Medium.copyWith(color: kGrey),
              ),
              48.verticalBox,
              InputField(
                controller: _passwordController,
                label: kNewPassword,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
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
              24.verticalBox,
              InputField(
                controller: _confirmController,
                label: kConfirmPassword,
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_outlined,
                    color: kDarkGrey,
                  ),
                ),
              ),
              40.verticalBox,
              BuildButton(
                text: kReset,
                onPressed: () {
                  context.router.push(const LoginRoute());
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
