import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/district/controller/districts_data.dart';
import 'package:trivago/features/group_book/repository/group_booking_repository.dart';
import 'package:trivago/models/booked_models/booked_models.dart';

import '../../home/controller/home_controller.dart';
import '../../home/repository/booking_repository.dart';

class GroupBookingController {
  int roomCalculator(DistrictsID e, WidgetRef ref) {
    final bookings = ref.watch(bookingsProvider).valueOrNull ?? <BookingData>[];
    final data = ref.read(homeControllerProvider).timeRange;
    final roomBooked = bookings.where((element) {
      return element.doDateTimeRangesOverlap(
              data?.start ?? DateTime.now(),
              data?.end ?? DateTime.now(),
              element.vacantDuration.start,
              element.vacantDuration.end) &&
          element.districtID == e;
    });
    final groupBookings =
        ref.watch(groupBookingsProvider).valueOrNull ?? <GroupBookingData>[];

    final groupRoomBooked = groupBookings.where((element) {
      return element.doDateTimeRangesOverlap(
              data?.start ?? DateTime.now(),
              data?.end ?? DateTime.now(),
              element.vacantDuration.start,
              element.vacantDuration.end) &&
          element.districtID == e;
    });
    int groupBookedSum = 0;
    final int roomUnbooked = roomData[e]?.length ?? -9999;
    for (var element in groupRoomBooked) {
      int total = element.roomBooked;
      groupBookedSum += total;
    }

    return (roomUnbooked - roomBooked.length - groupBookedSum);
  }

  int calculatingLogic(WidgetRef ref) {
    final home = ref.watch(homeControllerProvider);
    return (roomData[home.districtID]!.first.defaultPrice *
            home.roomBooked! *
            ((home.timeRange?.duration.inDays ?? 1) + 1) +
        50 * (home.personCount ?? 1));
  }
}
