import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getKeys();
    state = Set<String>.from(favorites);
  }

  Future<void> toggleFavorite(String date) async {
    final prefs = await SharedPreferences.getInstance();
    if (state.contains(date)) {
      prefs.remove(date);
      state = {...state}..remove(date);
    } else {
      prefs.setString(date, date);
      state = {...state}..add(date);
    }
  }
}

final favoritesStateNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (_) => FavoritesNotifier(),
);
