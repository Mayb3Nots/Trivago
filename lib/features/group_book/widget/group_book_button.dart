import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trivago/core/failure.dart';
import 'package:trivago/features/district/controller/districts_data.dart';
import 'package:trivago/features/group_book/controller/group_booking_controller.dart';
import 'package:trivago/features/group_book/repository/group_booking_repository.dart';
import 'package:trivago/features/home/controller/home_controller.dart';
import 'package:trivago/features/state/state.dart';

class GroupBookButton extends ConsumerStatefulWidget {
  const GroupBookButton({
    super.key,
    required this.errorCall,
  });
  final void Function(String) errorCall;
  @override
  ConsumerState createState() => _GroupBookButtonState();
}

class _GroupBookButtonState extends ConsumerState<GroupBookButton> {
  Either bookRoom(HomeState state, WidgetRef ref) {
    print(ref.read(groupBookingRepositoryProvider));
    try {
      return right(ref.read(groupBookingRepositoryProvider).bookRoom(
        context,
        state,
        (data) {
          widget.errorCall(data);
        },
      ));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    GroupBookingController groupBookingController = GroupBookingController();

    final availableRoom = groupBookingController.roomCalculator(
        ref.watch(homeControllerProvider).districtID ?? DistrictsID.A, ref);
    final home = ref.read(homeControllerProvider.notifier);
    return OutlinedButton(
        onPressed: () {
          print(ref.read(homeControllerProvider));
          if (ref.watch(homeControllerProvider).roomBooked! <= availableRoom) {
            bookRoom(ref.read(homeControllerProvider), ref);
            Navigator.pop(context);
          } else {
            print(ref.watch(homeControllerProvider).roomBooked!);
          }
        },
        child: const Text('Book'));
  }
}
