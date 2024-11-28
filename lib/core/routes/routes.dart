import 'package:go_router/go_router.dart';
import 'package:holiday_tracker/presentation/pages/next_holiday_page.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const NextHolidayPage(),
  )
]);
