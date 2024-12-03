import 'package:go_router/go_router.dart';
import 'package:holiday_tracker/presentation/pages/holiday_list_page.dart';
import 'package:holiday_tracker/presentation/pages/next_holiday_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const NextHolidayPage(),
    ),
    GoRoute(
      path: '/holidays',
      builder: (_, __) => const HolidayListPage(),
    ),
  ],
);
