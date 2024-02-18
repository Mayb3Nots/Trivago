import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trivago/core/failure.dart';
import 'package:trivago/core/snack_bar.dart';
import 'package:trivago/features/district/controller/districts_data.dart';
import 'package:trivago/features/group_book/controller/group_booking_controller.dart';
import 'package:trivago/features/group_book/widget/group_book_button.dart';
import 'package:trivago/features/home/controller/home_controller.dart';

class GroupBookingScreen extends ConsumerStatefulWidget {
  const GroupBookingScreen({super.key});

  @override
  ConsumerState createState() => _TourGroupButtonState();
}

class _TourGroupButtonState extends ConsumerState<GroupBookingScreen> {
  GroupBookingController groupBookingController = GroupBookingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    void updateCalculatedPrice() {
      setState(() {
        priceController.text =
            groupBookingController.calculatingLogic(ref).toString();
        ref
            .read(homeControllerProvider.notifier)
            .setTotalPrice(groupBookingController.calculatingLogic(ref));
        //
      });
    }

    void show(data) {
      showSnackBar(context, data);
    }

    // final availableRoom = groupBookingController.roomCalculator(
    //     ref.watch(homeControllerProvider).districtID ?? DistrictsID.A, ref);
    final homeFunction = ref.read(homeControllerProvider.notifier);

    ref.read(homeControllerProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
          onPressed: () {
            homeFunction.setDistrictID(DistrictsID.A);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Builder(
                      builder: (context) {
                        var height = MediaQuery.of(context).size.height;
                        var width = MediaQuery.of(context).size.width;

                        return Container(
                          padding: EdgeInsets.zero,
                          width: width * 0.8,
                          height: height * 0.8,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SfDateRangePicker(
                                    enablePastDates: false,
                                    headerStyle:
                                        const DateRangePickerHeaderStyle(
                                            textAlign: TextAlign.start),
                                    monthCellStyle:
                                        DateRangePickerMonthCellStyle(
                                            cellDecoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.white24))),
                                    monthViewSettings:
                                        const DateRangePickerMonthViewSettings(),
                                    view: DateRangePickerView.month,
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    onSelectionChanged: (d) {
                                      final value = d.value;
                                      if (value is PickerDateRange) {
                                        if (value.endDate != null) {
                                          homeFunction.setDateRange(
                                              DateTimeRange(
                                                  start: value.startDate!,
                                                  end: value.endDate!));
                                          updateCalculatedPrice();
                                        } else {
                                          homeFunction.setDateRange(
                                              DateTimeRange(
                                                  start: value.startDate!,
                                                  end: value.startDate!));
                                          updateCalculatedPrice();
                                        }
                                      } else {
                                        if (value is DateTimeRange) {
                                          homeFunction
                                              .setSelectedDate(value.start);
                                          updateCalculatedPrice();
                                        }
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextField(
                                      onChanged: (data) {
                                        homeFunction.setCustomerName(data);
                                        homeFunction.setRoomName(data);
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        border: OutlineInputBorder(),
                                        labelText: 'Name',
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (txt) {
                                      final data = int.tryParse(txt);
                                      if (data == null) return;
                                      homeFunction.setPhoneNumber(data);
                                    },
                                    validator: (value) {
                                      if (value == '') {
                                        return null;
                                      } else {
                                        final data = int.tryParse(value!);

                                        if (data == null) {
                                          return 'Must contain only Numbers!';
                                        }
                                      }
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [],
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone Number',
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      onChanged: (txt) {
                                        if (txt.isNotEmpty) {
                                          final data = int.tryParse(txt);
                                          if (data == null) return;
                                          homeFunction.setRoomBooked(data);
                                          updateCalculatedPrice();
                                        }
                                      },
                                      validator: (value) {
                                        if (value == '') {
                                          return null;
                                        } else {
                                          final data = int.tryParse(value!);

                                          if (data == null) {
                                            return 'Must contain only Numbers!';
                                          }
                                        }
                                        return null;
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [],
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        border: OutlineInputBorder(),
                                        labelText: 'Room Booked',
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (txt) {
                                      if (txt.isNotEmpty) {
                                        final data = int.tryParse(txt);
                                        if (data == null) return;
                                        homeFunction.setPersonCount(data);
                                        updateCalculatedPrice();
                                      }
                                    },
                                    validator: (value) {
                                      if (value == '') {
                                        return null;
                                      } else {
                                        final data = int.tryParse(value!);

                                        if (data == null) {
                                          return 'Must contain only Numbers!';
                                        }
                                      }
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [],
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      border: OutlineInputBorder(),
                                      labelText: 'People',
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      controller: priceController,
                                      onChanged: (txt) {
                                        if (txt.isNotEmpty) {
                                          final data = int.tryParse(txt);
                                          if (data == null) return;
                                          print('dada');
                                          homeFunction.setTotalPrice(data);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == '') {
                                          return null;
                                        } else {
                                          final data = int.tryParse(value!);

                                          if (data == null) {
                                            return 'Must contain only Numbers!';
                                          }
                                        }
                                        return null;
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [],
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(5),
                                        border: const OutlineInputBorder(),
                                        labelText: 'Price',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'District',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  DistrictButtonBar(id: (id) {
                                    updateCalculatedPrice();
                                  }),
                                  GroupBookButton(
                                    errorCall: (data) {
                                      show(data);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                });
          },
          icon: const Icon(Icons.group_add),
          label: const Text('Group')),
    );
  }
}

const List<DistrictsID> districtsID = [
  DistrictsID.A,
  DistrictsID.B,
  DistrictsID.C,
  DistrictsID.D,
  DistrictsID.E,
  DistrictsID.F,
  DistrictsID.G
];

class DistrictButtonBar extends ConsumerStatefulWidget {
  const DistrictButtonBar({
    super.key,
    required this.id,
  });
  final void Function(DistrictsID) id;
  @override
  ConsumerState createState() => _DistrictButtonBarState();
}

class _DistrictButtonBarState extends ConsumerState<DistrictButtonBar> {
  final List<bool> _selectedDistrict = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(homeControllerProvider);
    final width = MediaQuery.of(context).size.width;

    return ToggleButtons(
      isSelected: _selectedDistrict,
      constraints: BoxConstraints(
        minWidth: width / 9,
      ),
      children: districtsID.map((e) {
        GroupBookingController groupBookingController =
            GroupBookingController();

        final availableRoom = groupBookingController.roomCalculator(e, ref);

        return Column(
          children: [
            Text(
              e.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: width / 50 + 20,
              child: const Divider(
                color: Colors.grey,
                height: 0,
                thickness: 1,
              ),
            ),
            Text(availableRoom.toString())
          ],
        );
      }).toList(),
      onPressed: (int index) {
        setState(() {
          // The button that is tapped is set to true, and the others to false.
          for (int i = 0; i < _selectedDistrict.length; i++) {
            _selectedDistrict[i] = i == index;
          }

          ref
              .read(homeControllerProvider.notifier)
              .setDistrictID(districtsID[index]);
          widget.id(districtsID[index]);
        });
      },
    );
  }
}
