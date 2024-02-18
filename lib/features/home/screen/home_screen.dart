import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trivago/constants/colour.dart';
import 'package:trivago/features/group_book/screen/group_booking_screen.dart';
import 'package:trivago/features/home/widget/drawer.dart';
import 'package:trivago/features/auth/controller/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:trivago/features/home/controller/home_controller.dart';
import 'package:trivago/features/home/screen/dsitrict_area.dart';
import 'package:trivago/features/home/screen/tab_bar_view.dart';
import 'package:trivago/features/home/widget/select_date_button.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

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
    final user = ref.watch(userProvider);
    ref.watch(homeControllerProvider);
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
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        drawer: const GeneralDrawer(),
        body: HomeScreenScaffold(
          onDateDecrease: () {
            setState(() {
              selectedTime = selectedTime.subtract(const Duration(days: 1));
              ref
                  .read(homeControllerProvider.notifier)
                  .setSelectedDate(selectedTime);
            });
          },
          onDateIncrease: () {
            setState(() {
              selectedTime = selectedTime.add(const Duration(days: 1));
              ref
                  .read(homeControllerProvider.notifier)
                  .setSelectedDate(selectedTime);
            });
          },
          time: (data) {
            setState(() {
              ref.read(homeControllerProvider.notifier).setSelectedDate(data);
              selectedTime = data;
            });
          },
        ),
      ),
    );
  }
}

class HomeScreenScaffold extends ConsumerStatefulWidget {
  HomeScreenScaffold({
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
    ref.watch(homeControllerProvider);
    return DefaultTabController(
      length: 7,
      child: Column(
        children: [
          const DistrictView(),
          Divider(
            height: 0,
          ),
          const CheckBoxArea(),
          Divider(
            height: 0,
          ),
          const TabBarArea(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  ref.watch(homeControllerProvider);
                  widget.onDateDecrease();
                },
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
                iconSize: 40,
              ),
              Expanded(
                child: SelectDateButton(widget: widget, ref: ref),
              ),
              Expanded(child: GroupBookingScreen()),
              IconButton(
                onPressed: () {
                  ref.watch(homeControllerProvider);
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
