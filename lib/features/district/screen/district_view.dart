import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trivago/constants/colour.dart';
import 'package:trivago/converter/date_time_range_converter.dart';
import 'package:trivago/core/snack_bar.dart';
import 'package:trivago/features/district/widget/book_button.dart';
import 'package:trivago/features/district/widget/booked_widget.dart';
import 'package:trivago/features/home/controller/home_controller.dart';
import 'package:trivago/features/home/repository/booking_repository.dart';

import 'package:trivago/models/booked_models/booked_models.dart';
import 'package:trivago/models/room_models/room_model.dart';

class DistrictTiles extends ConsumerWidget {
  DistrictTiles({
    required this.roomModel,
    super.key,
  });

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(homeControllerProvider);
    final bookings = ref.watch(bookingsProvider).valueOrNull ?? <BookingData>[];

    final booking = bookings.firstWhereOrNull(
      (element) {
        return element.roomName == roomModel.name &&
            element.districtID == roomModel.district &&
            ref.read(homeControllerProvider).selectedDate.isBetween(
                element.vacantDuration.start, element.vacantDuration.end);
      },
    );
    HomeController homeController = HomeController();
    final availableRoom = homeController.roomCalculator(
        ref.watch(homeControllerProvider).selectedDate,
        ref,
        roomModel.district);

    void show(data) {
      showSnackBar(context, data);
    }

    TextEditingController priceController = TextEditingController();
    void updateCalculatedPrice() {
      priceController.text = homeController.calculatingLogic(ref).toString();
      ref
          .read(homeControllerProvider.notifier)
          .setTotalPrice(homeController.calculatingLogic(ref));
    }

    Color colorDetermine() {
      if (availableRoom == 0) {
        return Colors.red.withOpacity(0.7);
      } else {
        return booking != null
            ? Colors.red.withOpacity(0.7)
            : Colors.green.withOpacity(0.7);
      }
    }

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    roomModel.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                insetPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                content: Builder(
                  builder: (context) {
                    final homeFunction =
                        ref.read(homeControllerProvider.notifier);
                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
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
                                initialDisplayDate: ref
                                    .read(homeControllerProvider)
                                    .selectedDate,
                                enablePastDates: false,
                                headerStyle: const DateRangePickerHeaderStyle(
                                    textAlign: TextAlign.start),
                                monthCellStyle: DateRangePickerMonthCellStyle(
                                  blackoutDateTextStyle: TextStyle(
                                    color: Colors.redAccent.withOpacity(0.4),
                                  ),
                                  cellDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(color: Colors.white24),
                                  ),
                                ),
                                monthViewSettings:
                                    DateRangePickerMonthViewSettings(
                                  blackoutDates: homeController.blackOutDates(
                                    ref,
                                    roomModel.district,
                                    roomModel.name,
                                  ),
                                ),
                                view: DateRangePickerView.month,
                                onSelectionChanged: (d) {
                                  final value = d.value;
                                  if (value is PickerDateRange) {
                                    if (value.endDate != null) {
                                      homeFunction.setDateRange(DateTimeRange(
                                          start: value.startDate!,
                                          end: value.endDate!));
                                      updateCalculatedPrice();
                                    } else {
                                      print('2');
                                      homeFunction.setDateRange(DateTimeRange(
                                          start: value.startDate!,
                                          end: value.startDate!));
                                      updateCalculatedPrice();
                                    }
                                  } else {
                                    if (value is DateTimeRange) {
                                      homeFunction.setSelectedDate(value.start);
                                      updateCalculatedPrice();
                                    }
                                  }
                                },
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                              ),
                              const BookedList(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextField(
                                  onChanged: ref
                                      .read(homeControllerProvider.notifier)
                                      .setCustomerName,
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
                              ),
                              TextFormField(
                                controller: priceController,
                                onChanged: (txt) {
                                  if (txt.isNotEmpty) {
                                    final data = int.tryParse(txt);
                                    if (data == null) return;
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
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(),
                                  labelText: 'Price',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.15,
                              ),
                              BookButton(
                                parentContext: context,
                                name: roomModel.name,
                                districtID: roomModel.district,
                                availableRoom: availableRoom,
                                errorCall: (data) {
                                  show(data);
                                },
                              )
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
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: Container(
            decoration: BoxDecoration(
                color: colorDetermine(),
                borderRadius:
                    const BorderRadiusDirectional.all(Radius.circular(10))),
            padding: const EdgeInsets.all(10),
            child: Text(
              roomModel.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
