import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:trivago/features/home/controller/home_controller.dart';
import 'package:trivago/features/home/screen/home_screen.dart';

class SelectDateButton extends StatelessWidget {
  const SelectDateButton({
    super.key,
    required this.widget,
    required this.ref,
  });

  final HomeScreenScaffold widget;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
          onPressed: () => Scaffold.of(context).showBottomSheet(
                (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: SfCalendar(
                        view: CalendarView.month,
                        onSelectionChanged: (CalendarSelectionDetails details) {
                          widget.time(details.date!);
                          ref
                              .read(homeControllerProvider.notifier)
                              .setSelectedDate(details.date!);

                          Navigator.pop(context);
                        }),
                  );
                },
              ),
          icon: Icon(Icons.calendar_month),
          label: Text(
            'Select Date',
          )),
    );
  }
}
