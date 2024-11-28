import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/common/common_state.dart';
import 'package:holiday_tracker/core/failures/failure.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';
import 'package:holiday_tracker/infra/datasources/remote/holiday_remote_datasource.dart';

typedef HolidayState = CommonState<Failure, List<HolidayEntity>>;

class HolidayNotifier extends StateNotifier<HolidayState> {
  final HolidayRemoteDatasource datasource;
  HolidayNotifier(this.datasource) : super(const HolidayState.initial());

  Future<void> fetchHolidays() async {
    state = const HolidayState.loadInProgress();
    final result = await datasource.fetchHolidays();

    state = HolidayState.loadSuccess(result);
  }
}

final holidayStateNotifierProvider =
    StateNotifierProvider.autoDispose<HolidayNotifier, HolidayState>(
  (ref) => HolidayNotifier(ref.read(holidayRemoteDatasourceProvider)),
);
