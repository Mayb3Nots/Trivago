// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:trivago/features/auth/screen/sign_in_screen.dart' as _i4;
import 'package:trivago/features/booking/screen/booking_overview_screen.dart'
    as _i1;
import 'package:trivago/features/group_booking/screen/group_booking_overview_screen.dart'
    as _i2;
import 'package:trivago/features/home/screen/home_screen.dart' as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    BookingOverviewRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BookingOverviewScreen(),
      );
    },
    GroupBookingOverviewRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GroupBookingOverviewScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignInScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BookingOverviewScreen]
class BookingOverviewRoute extends _i5.PageRouteInfo<void> {
  const BookingOverviewRoute({List<_i5.PageRouteInfo>? children})
      : super(
          BookingOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingOverviewRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GroupBookingOverviewScreen]
class GroupBookingOverviewRoute extends _i5.PageRouteInfo<void> {
  const GroupBookingOverviewRoute({List<_i5.PageRouteInfo>? children})
      : super(
          GroupBookingOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupBookingOverviewRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignInScreen]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
