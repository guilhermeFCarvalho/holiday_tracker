import 'package:flutter/material.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:holiday_tracker/presentation/notifiers/favorites_notifier.dart';

class HolidayWidget extends ConsumerWidget {
  final HolidayDto dto;

  const HolidayWidget({
    super.key,
    required this.dto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesStateNotifierProvider);
    final isFavorite = favorites.contains(dto.holiday.date);

    return Row(
      children: [
        Text(dto.holiday.localName),
        const Spacer(),
        Text(dto.holiday.date),
        IconButton(
          onPressed: () {
            ref
                .read(favoritesStateNotifierProvider.notifier)
                .toggleFavorite(dto.holiday.date);
          },
          icon: Icon(
            Icons.bookmark,
            color: isFavorite ? Colors.yellow : null,
          ),
        ),
      ],
    );
  }
}
