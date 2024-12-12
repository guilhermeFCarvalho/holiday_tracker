import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/common/themes/theme_notifier.dart';
import 'package:holiday_tracker/core/common/themes/themes.dart';
import 'package:holiday_tracker/core/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeStateNotifierProvider);

    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier,
      routerConfig: routes,
    );
  }
}
