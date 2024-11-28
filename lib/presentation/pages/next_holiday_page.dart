import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:holiday_tracker/presentation/notifiers/holiday_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NextHolidayPage extends HookConsumerWidget {
  const NextHolidayPage({super.key});

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

        return null;
      },
    );

    return Scaffold(
      body: Consumer(builder: (_, cRef, __) {
        final state = cRef.watch(holidayStateNotifierProvider);
        return state.maybeWhen(
          loadSuccess: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...data.map(
                (holiday) => Text(holiday.localName),
              ),
            ],
          ),
          loadInProgress: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loadFailure: (failure) => Center(
            child: Text(failure.name),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      }),
    );
  }
}
