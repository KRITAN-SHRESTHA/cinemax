import 'package:cinemax/config/routes/routes.dart';
import 'package:cinemax/core/services/injector.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(ProviderScope(child: MainApp(appRouter: getIt<AppRouter>())));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: kDark),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
