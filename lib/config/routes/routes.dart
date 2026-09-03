import 'package:auto_route/auto_route.dart';
import 'package:cinemax/features/auth/presentation/pages/login_page.dart';
import 'package:cinemax/features/auth/presentation/pages/login_sign_up_page.dart';
import 'package:cinemax/features/auth/presentation/pages/onboarding_page.dart';
import 'package:cinemax/features/auth/presentation/pages/splash_page.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    //* The screen the app opens on: move `initial` to start somewhere else.
    AutoRoute(page: LoginSignUPRoute.page, initial: true),
    AutoRoute(page: SplashRoute.page),
    AutoRoute(page: OnBoardingRoute.page, keepHistory: false),
    AutoRoute(page: LoginRoute.page, keepHistory: false),

    // AutoRoute(
    //   page: DashboardRoute.page,
    //   initial: true,
    //   keepHistory: true,
    //   children: [
    //     AutoRoute(page: HomeRoute.page, initial: true),
    //     AutoRoute(page: SearchRoute.page),
    //     AutoRoute(page: FavouriteRoute.page),
    //     AutoRoute(page: CartRoute.page),
    //     AutoRoute(page: AccountRoute.page),
    //   ],
    // ),
  ];
}
