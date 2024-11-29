import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:holiday_tracker/presentation/notifiers/holiday_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

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
          loadSuccess: (data) {
            final nextHoliday = data.getNextHoliday();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[
                nextHoliday != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("O próximo feriado é ${nextHoliday.localName}"),
                        Text("Faltam ${nextHoliday.daysUntilHoliday()} dias"),
                        Text("Vai cair em um ${nextHoliday.getWeekDayName()}")
                      ],
                    )
                  : const Text("Não foi encontrado nenhum feriado próximo"),
              ] 
            );
          },
          loadInProgress: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loadFailure: (failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Ocorreu um erro, tente novamente"),
                TextButton(
                    onPressed: () {
                      holidayNotifier.fetchHolidays();
                    },
                    child: const Text("Recarregar"))
              ],
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      }),
    );
  }
}
