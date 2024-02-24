import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/booking/controller/booking_controller.dart';
import 'package:trivago/features/booking/repository/booking_repository.dart';
import 'package:trivago/features/group_booking/repository/group_booking_repository.dart';
import 'package:trivago/models/booked_models/booked_models.dart';
import 'package:trivago/models/room_models/room_model_data.dart';

class GroupBookingController {
  int roomCalculator(DistrictsID e, WidgetRef ref) {
    final bookings = ref.watch(bookingsProvider).valueOrNull ?? <BookingData>[];
    final data = ref.watch(bookingControllerProvider).timeRange;
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
    return (roomData[ref.read(bookingControllerProvider).districtID]!
                .first
                .defaultPrice *
            ref.read(bookingControllerProvider).roomBooked! *
            ((ref.read(bookingControllerProvider).timeRange?.duration.inDays ??
                    1) +
                1) +
        50 * (ref.read(bookingControllerProvider).personCount ?? 1));
  }
}
