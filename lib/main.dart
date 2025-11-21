import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/hevy_theme.dart';
import 'core/navigation/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ZenXApp(),
    ),
  );
}

class ZenXApp extends StatelessWidget {
  const ZenXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ZenX',
      theme: HevyTheme.darkTheme, // Use Hevy-inspired dark theme
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}












