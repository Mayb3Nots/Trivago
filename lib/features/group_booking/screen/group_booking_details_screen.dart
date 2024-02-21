import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:trivago/constants/colour.dart';
import 'package:trivago/features/booking/repository/booking_repository.dart';
import 'package:trivago/features/group_booking/repository/group_booking_repository.dart';
import 'package:trivago/models/booked_models/booked_models.dart';
import 'package:trivago/models/room_models/room_model.dart';
import 'package:trivago/models/room_models/room_model_data.dart';

class GroupDetailsDialog extends ConsumerStatefulWidget {
  const GroupDetailsDialog({
    super.key,
    required this.groupBookingData,
  });
  final GroupBookingData groupBookingData;

  @override
  ConsumerState createState() => __ShowDialogState();
}

class __ShowDialogState extends ConsumerState<GroupDetailsDialog> {
  final List<String> selectedRoomList = [];

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingsProvider).valueOrNull ?? <BookingData>[];

    final booking = bookings.where(
      (element) {
        return element.districtID == widget.groupBookingData.districtID &&
            element.doDateTimeRangesOverlap(
                widget.groupBookingData.vacantDuration.start,
                widget.groupBookingData.vacantDuration.end,
                element.vacantDuration.start,
                element.vacantDuration.end);
      },
    );

    Color colorDetermine(String name) {
      final selected = selectedRoomList.firstWhereOrNull((element) {
        return element.contains(name);
      });
      if (selected != null) {
        return Colors.green.withOpacity(0.7);
      }
      final booked =
          booking.firstWhereOrNull((element) => element.roomName == name);
      return booked != null
          ? Colors.red.withOpacity(0.7)
          : Colors.grey.withOpacity(0.7);
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Center(
        child: SizedBox(
          width: width * 0.8,
          child: Text(
            textAlign: TextAlign.center,
            widget.groupBookingData.customerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Builder(builder: (context) {
        return Container(
          padding: EdgeInsets.zero,
          height: height * 0.8,
          width: width * 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.groupBookingData.roomBooked.toString()),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(Icons.house),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Pallete.greyColor,
                        )),
                    child: Text(
                      widget.groupBookingData.districtID.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Pallete.peachColor.withOpacity(0.6),
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (RoomModel room
                        in roomData[widget.groupBookingData.districtID]!)
                      GestureDetector(
                        onTap: () {
                          final booked = booking.firstWhereOrNull(
                              (element) => element.roomName == room.name);
                          if (booked != null) {
                            return;
                          }
                          if (selectedRoomList.contains(room.name)) {
                            selectedRoomList.remove(room.name);
                          } else {
                            selectedRoomList.add(room.name);
                          }
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorDetermine(room.name),
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(10))),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            room.name,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${widget.groupBookingData.customerName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text('Person Count: ${widget.groupBookingData.personCount}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    Text(
                      'Phone Number: ${widget.groupBookingData.phoneNumber}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      'Total Price: ${widget.groupBookingData.totalPrice}฿',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const Divider(),
                    if (widget.groupBookingData.byCash == true)
                      const Text(
                        '•By Cash',
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 12),
                      ),
                    if (widget.groupBookingData.hasBreakfastService == true)
                      const Text(
                        '•Breakfast Available',
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 12),
                      ),
                    if (widget.groupBookingData.unknownBool1 == true)
                      const Text(
                        '•村⺠，导游， 司机',
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 12),
                      ),
                    if (widget.groupBookingData.unknownBool2 == true)
                      const Text(
                        '•股东',
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 12),
                      ),
                    if (widget.groupBookingData.unknownBool3 == true)
                      const Text(
                        '•政府⼈员',
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 12),
                      ),
                    Row(
                      children: [
                        GroupDetailsButton(
                          function: () {
                            ref
                                .watch(groupBookingRepositoryProvider)
                                .deleteGroupBooking(widget.groupBookingData.id);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          button: 'Delete',
                          colour: Colors.red,
                          confirmTitle: 'Confirm Delete Booking?',
                          selectedRoomList: selectedRoomList,
                          roomBooked: widget.groupBookingData.roomBooked,
                        ),
                        GroupDetailsButton(
                          confirmTitle: 'Confirm Booking?',
                          function: () {
                            if (selectedRoomList.length ==
                                widget.groupBookingData.roomBooked) {
                              ref
                                  .watch(groupBookingRepositoryProvider)
                                  .convertGroupToSingle(selectedRoomList, ref,
                                      widget.groupBookingData);
                              ref
                                  .watch(groupBookingRepositoryProvider)
                                  .deleteGroupBooking(
                                      widget.groupBookingData.id);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          button: 'Book',
                          colour: Colors.green,
                          selectedRoomList: selectedRoomList,
                          roomBooked: widget.groupBookingData.roomBooked,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class GroupDetailsButton extends StatelessWidget {
  const GroupDetailsButton(
      {super.key,
      required this.button,
      required this.colour,
      required this.function,
      required this.confirmTitle,
      required this.selectedRoomList,
      required this.roomBooked});
  final String button;
  final Color colour;
  final String confirmTitle;
  final Function function;
  final int roomBooked;
  final List selectedRoomList;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: colour),
          onPressed: () {
            const test = SizedBox();
            final show = showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      width: width * 3 / 4,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Pallete.peachColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            confirmTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent),
                                  child: const Text(
                                    'Cancel',
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  function();

                                  // AutoRouter.of(context)
                                  //     .push(GroupBookingOverviewRoute());
                                },
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
            if (button == 'Book' && selectedRoomList.length == roomBooked) {
              show;
            } else if (button == 'Delete') {
              show;
            } else {
              test;
            }
          },
          child: Text(button),
        ),
      ),
    );
  }
}
