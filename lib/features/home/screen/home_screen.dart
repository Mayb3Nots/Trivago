import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/constants/colour.dart';
import 'package:trivago/features/auth/controller/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:trivago/features/booking/controller/booking_controller.dart';
import 'package:trivago/features/home/widget/drawer.dart';
import 'package:trivago/features/home/widget/home_tab_bar.dart';
import 'package:trivago/features/home/widget/select_date_button.dart';
import 'package:trivago/features/group_booking/screen/group_booking_screen.dart';
import 'package:trivago/features/home/widget/dsitrict_area.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime selectedTime = DateTime.now();
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.watch(bookingControllerProvider);
    return MaterialApp(
      theme: Pallete.lightModeAppTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.peachColor,
          title: Text(DateFormat.yMMMd().format(selectedTime)),
          centerTitle: false,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayDrawer(context),
              icon: const Icon(Icons.menu),
            );
          }),
          // actions: [
          //   // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          // ],
        ),
        drawer: const GeneralDrawer(),
        body: HomeScreenScaffold(
          onDateDecrease: () {
            setState(() {
              selectedTime = selectedTime.subtract(const Duration(days: 1));
              ref
                  .read(bookingControllerProvider.notifier)
                  .setSelectedDate(selectedTime);
            });
          },
          onDateIncrease: () {
            setState(() {
              selectedTime = selectedTime.add(const Duration(days: 1));
              ref
                  .read(bookingControllerProvider.notifier)
                  .setSelectedDate(selectedTime);
            });
          },
          time: (data) {
            setState(() {
              ref
                  .read(bookingControllerProvider.notifier)
                  .setSelectedDate(data);
              selectedTime = data;
            });
          },
        ),
      ),
    );
  }
}

class HomeScreenScaffold extends ConsumerStatefulWidget {
  const HomeScreenScaffold({
    super.key,
    required this.onDateIncrease,
    required this.onDateDecrease,
    required this.time,
  });

  final void Function() onDateIncrease;
  final void Function() onDateDecrease;
  final void Function(DateTime) time;
  @override
  ConsumerState createState() => _HomeScreenScaffoldState();
}

class _HomeScreenScaffoldState extends ConsumerState<HomeScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    ref.watch(bookingControllerProvider);
    return DefaultTabController(
      length: 7,
      child: Column(
        children: [
          const DistrictView(),
          const Divider(
            height: 0,
          ),
          const CheckBoxArea(),
          const Divider(
            height: 0,
          ),
          const HomeTabBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  ref.watch(bookingControllerProvider);
                  widget.onDateDecrease();
                },
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
                iconSize: 40,
              ),
              Expanded(
                child: SelectDateButton(widget: widget, ref: ref),
              ),
              const Expanded(child: GroupBookingScreen()),
              IconButton(
                onPressed: () {
                  ref.watch(bookingControllerProvider);
                  widget.onDateIncrease();
                },
                icon: const Icon(Icons.keyboard_arrow_right),
                iconSize: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
