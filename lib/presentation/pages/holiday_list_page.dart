import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:holiday_tracker/core/failures/presentation/widgets/load_failure_widget.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';
import 'package:holiday_tracker/presentation/notifiers/holiday_notifier.dart';
import 'package:holiday_tracker/presentation/widgets/holiday_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HolidayListPage extends HookConsumerWidget {
  const HolidayListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidayNotifier = ref.watch(holidayStateNotifierProvider.notifier);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            holidayNotifier.fetchHolidays();
          },
        );
      },
    );

    final devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Padding(
        padding: devicePadding.copyWith(
          left: 20,
          right: 20,
        ),
        child: Consumer(builder: (_, cRef, __) {
          final state = cRef.watch(holidayStateNotifierProvider);
          return state.maybeWhen(
            loadSuccess: (data) => Column(
              children: data
                  .map(
                    (e) => HolidayWidget(
                        dto: HolidayDto(holiday: e, isFavorite: false)),
                  )
                  .toList(),
            ),
            loadInProgress: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loadFailure: (failure) => LoadFailureWidget(
              reload: holidayNotifier.fetchHolidays,
            ),
            orElse: () => const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
