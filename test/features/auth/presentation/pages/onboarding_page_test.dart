// import 'package:cinemax/core/utils/string.dart';
// import 'package:cinemax/features/auth/presentation/pages/onboarding_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   Future<void> pumpAt(WidgetTester tester, Size size) async {
//     tester.view.physicalSize = size;
//     tester.view.devicePixelRatio = 1.0;
//     addTearDown(tester.view.resetPhysicalSize);
//     addTearDown(tester.view.resetDevicePixelRatio);

//     await tester.pumpWidget(
//       const ProviderScope(child: MaterialApp(home: OnboardingPage())),
//     );
//     await tester.pumpAndSettle();
//   }

//   testWidgets('renders all 3 pages with no overflow at 375x812', (
//     tester,
//   ) async {
//     await pumpAt(tester, const Size(375, 812));

//     expect(find.text(kOnboardingTitle1), findsOneWidget);

//     final PageView pageView = tester.widget(find.byType(PageView));
//     final PageController controller = pageView.controller!;

//     controller.jumpToPage(1);
//     await tester.pumpAndSettle();
//     expect(find.text(kOnboardingTitle2), findsOneWidget);

//     controller.jumpToPage(2);
//     await tester.pumpAndSettle();
//     expect(find.text(kOnboardingTitle3), findsOneWidget);

//     expect(tester.takeException(), isNull);
//   });

//   testWidgets('renders all 3 pages with no overflow at 320x568', (
//     tester,
//   ) async {
//     await pumpAt(tester, const Size(320, 568));

//     expect(find.text(kOnboardingTitle1), findsOneWidget);

//     final PageView pageView = tester.widget(find.byType(PageView));
//     final PageController controller = pageView.controller!;

//     controller.jumpToPage(1);
//     await tester.pumpAndSettle();
//     expect(find.text(kOnboardingTitle2), findsOneWidget);

//     controller.jumpToPage(2);
//     await tester.pumpAndSettle();
//     expect(find.text(kOnboardingTitle3), findsOneWidget);

//     expect(tester.takeException(), isNull);
//   });
// }
