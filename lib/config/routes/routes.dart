import 'package:auto_route/auto_route.dart';
import 'package:cinemax/features/auth/presentation/pages/create_new_password_page.dart';
import 'package:cinemax/features/auth/presentation/pages/dashboard_page.dart';
import 'package:cinemax/features/auth/presentation/pages/download_page.dart';
import 'package:cinemax/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:cinemax/features/auth/presentation/pages/home_page.dart';
import 'package:cinemax/features/auth/presentation/pages/login_page.dart';
import 'package:cinemax/features/auth/presentation/pages/login_sign_up_page.dart';
import 'package:cinemax/features/auth/presentation/pages/onboarding_page.dart';
import 'package:cinemax/features/auth/presentation/pages/profile_page.dart';
import 'package:cinemax/features/auth/presentation/pages/search_page.dart';
import 'package:cinemax/features/auth/presentation/pages/signup_page.dart';
import 'package:cinemax/features/auth/presentation/pages/splash_page.dart';
import 'package:cinemax/features/auth/presentation/pages/verification_page.dart';
import 'package:flutter/material.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    //* The screen the app opens on: move `initial` to start somewhere else.
    AutoRoute(page: LoginSignUPRoute.page, initial: false),
    AutoRoute(page: SplashRoute.page),
    //* keepHistory: false drops the route from the stack as soon as it pushes
    //* another one, so it is only for screens you never want to come back to.
    AutoRoute(page: OnBoardingRoute.page, keepHistory: false),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page, keepHistory: false),
    AutoRoute(page: VerificationRoute.page, keepHistory: false),
    AutoRoute(page: CreateNewPasswordRoute.page, keepHistory: false),

    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      keepHistory: true,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: DownloadRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}
