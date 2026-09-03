import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/features/auth/presentation/pages/login_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kSoft),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LoginSignUPPage()),
    );
  }
}
