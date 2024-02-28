// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingsHash() => r'167827afcf72b071183ddc0511cd22de36bb92f2';

/// See also [bookings].
@ProviderFor(bookings)
final bookingsProvider = AutoDisposeStreamProvider<List<BookingData>>.internal(
  bookings,
  name: r'bookingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BookingsRef = AutoDisposeStreamProviderRef<List<BookingData>>;
String _$relevantBookingsHash() => r'0ffc5a328df84244dec53e5a96f2ba657cd108fa';

/// See also [relevantBookings].
@ProviderFor(relevantBookings)
final relevantBookingsProvider =
    AutoDisposeStreamProvider<List<BookingData>>.internal(
  relevantBookings,
  name: r'relevantBookingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$relevantBookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RelevantBookingsRef = AutoDisposeStreamProviderRef<List<BookingData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
