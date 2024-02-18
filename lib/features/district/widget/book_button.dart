import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trivago/core/failure.dart';
import 'package:trivago/core/snack_bar.dart';
import 'package:trivago/core/type_defs.dart';
import 'package:trivago/features/district/controller/districts_data.dart';
import 'package:trivago/features/home/controller/home_controller.dart';
import 'package:trivago/features/home/repository/booking_repository.dart';

import 'package:trivago/features/state/state.dart';
import 'package:trivago/models/booked_models/booked_models.dart';

class BookButton extends ConsumerStatefulWidget {
  const BookButton(
      {required this.parentContext,
      required this.availableRoom,
      required this.name,
      required this.districtID,
      required this.errorCall,
      super.key});
  final String name;

  final BuildContext parentContext;
  final DistrictsID districtID;
  final int availableRoom;
  final void Function(String) errorCall;

  @override
  ConsumerState createState() => _BookButtonState();
}

class _BookButtonState extends ConsumerState<BookButton> {
  Either bookRoom(HomeState state, WidgetRef ref) {
    try {
      if (widget.availableRoom > 0) {
        print('dadad');
        return right(
          ref.read(bookingRepositoryProvider).bookRoom(
            BookingData(
                id: FirebaseFirestore.instance.collection('dog').doc().id,
                districtID: state.districtID!,
                vacantDuration: state.timeRange!,
                customerName: state.customerName!,
                totalPrice: state.totalPrice!,
                personCount: state.personCount!,
                phoneNumber: state.phoneNumber!,
                byCash: state.byCash!,
                roomName: state.roomName!,
                hasBreakfastService: state.hasBreakfast!,
                unknownBool1: state.unknownBool1!,
                unknownBool2: state.unknownBool2!,
                unknownBool3: state.unknownBool3!),
            (data) {
              widget.errorCall(data);
            },
          ),
        );
      } else {
        return left('Room unavailable');
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final home = ref.read(homeControllerProvider.notifier);
    return OutlinedButton(
        onPressed: () {
          home.setRoomName(widget.name);

          home.setDistrictID(widget.districtID);
          bookRoom(ref.read(homeControllerProvider), ref);
          Navigator.pop(context);
        },
        child: const Text('Book'));
  }
}
