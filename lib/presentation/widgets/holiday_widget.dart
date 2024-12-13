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

  String formatDate(String isoDate) {
    DateTime date = DateTime.parse(isoDate);

    String formattedDate =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

    return formattedDate;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesStateNotifierProvider);
    final isFavorite = favorites.contains(dto.holiday.date);

    return Row(
      children: [
        Text(dto.holiday.localName),
        const Spacer(),
        Text(
          formatDate(dto.holiday.date),
        ),
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
