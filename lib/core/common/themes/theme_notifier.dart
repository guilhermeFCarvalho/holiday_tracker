import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void changeTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeStateNotifierProvider =
    StateNotifierProvider.autoDispose<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
