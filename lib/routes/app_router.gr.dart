// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:trivago/features/analytics/screen/analytics_screen.dart' as _i1;
import 'package:trivago/features/auth/screen/sign_in_screen.dart' as _i5;
import 'package:trivago/features/booking/screen/booking_overview_screen.dart'
    as _i2;
import 'package:trivago/features/group_booking/screen/group_booking_overview_screen.dart'
    as _i3;
import 'package:trivago/features/home/screen/home_screen.dart' as _i4;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AnalyticsRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnalyticsScreen(),
      );
    },
    BookingOverviewRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BookingOverviewScreen(),
      );
    },
    GroupBookingOverviewRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GroupBookingOverviewScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignInScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnalyticsScreen]
class AnalyticsRoute extends _i6.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AnalyticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyticsRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BookingOverviewScreen]
class BookingOverviewRoute extends _i6.PageRouteInfo<void> {
  const BookingOverviewRoute({List<_i6.PageRouteInfo>? children})
      : super(
          BookingOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingOverviewRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GroupBookingOverviewScreen]
class GroupBookingOverviewRoute extends _i6.PageRouteInfo<void> {
  const GroupBookingOverviewRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GroupBookingOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupBookingOverviewRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SignInScreen]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
