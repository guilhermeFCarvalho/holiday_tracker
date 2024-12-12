import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:holiday_tracker/core/common/themes/theme_notifier.dart';
import 'package:holiday_tracker/core/failures/presentation/widgets/load_failure_widget.dart';
import 'package:holiday_tracker/core/native/native_service.dart';
import 'package:holiday_tracker/core/routes/routes.dart';
import 'package:holiday_tracker/presentation/notifiers/holiday_notifier.dart';
import 'package:holiday_tracker/presentation/widgets/change_theme_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

class NextHolidayPage extends HookConsumerWidget {
  const NextHolidayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidayNotifier = ref.watch(holidayStateNotifierProvider.notifier);

    final themeNotifier = ref.read(themeStateNotifierProvider.notifier);

     final NativeService nativeService = NativeService();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            holidayNotifier.fetchHolidays();
             nativeService.showNotification("ATENÇÃO", "hoje é feriado!");
          },
        );

        return null;
      },
    );

    final paddingVertical = MediaQuery.of(context).padding.vertical;

    return Scaffold(
      appBar: AppBar(
        leading: ChangeThemeWidget(
          changeTheme: themeNotifier.changeTheme,
          currentTheme: ref.read(themeStateNotifierProvider),
        ),
      ),
      body: Consumer(builder: (_, cRef, __) {
        final state = cRef.watch(holidayStateNotifierProvider);
        return state.maybeWhen(
          loadSuccess: (data) {
            final nextHoliday = data
                .map(
                  (e) => e.holiday,
                )
                .toList()
                .getNextHoliday();
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: paddingVertical + 12,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  nextHoliday != null
                      ? Column(
                          children: [
                            Text(
                                "O próximo feriado é ${nextHoliday.localName}"),
                            Text(
                                "Faltam ${nextHoliday.daysUntilHoliday()} dias"),
                            Text(
                                "Vai cair em um ${nextHoliday.getWeekDayName()}"),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : const Text("Não foi encontrado nenhum feriado próximo"),
                  ElevatedButton(
                    onPressed: () {
                      routes.push('/holidays');
                    },
                    child: const Text(
                      "Ver os próximos feriados",
                    ),
                  ),
                ],
              ),
            );
          },
          loadInProgress: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loadFailure: (failure) => Center(
            child: LoadFailureWidget(
              reload: () {
                holidayNotifier.fetchHolidays();
              },
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      }),
    );
  }
}
