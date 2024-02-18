import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/district/controller/districts_data.dart';
import 'package:trivago/features/district/screen/district_view.dart';
import 'package:trivago/features/group_book/repository/group_booking_repository.dart';
import 'package:trivago/features/group_book/screen/group_booking_screen.dart';
import 'package:trivago/features/home/repository/booking_repository.dart';

import 'package:trivago/models/booked_models/booked_models.dart';

import '../controller/home_controller.dart';

class TabBarArea extends ConsumerStatefulWidget {
  const TabBarArea({super.key});

  @override
  ConsumerState createState() => _TabBarAreaState();
}

class _TabBarAreaState extends ConsumerState<TabBarArea> {
  @override
  Widget build(BuildContext context) {
    return const TabBar(tabs: [
      TabBars(DistrictsID.A),
      TabBars(DistrictsID.B),
      TabBars(DistrictsID.C),
      TabBars(DistrictsID.D),
      TabBars(DistrictsID.E),
      TabBars(DistrictsID.F),
      TabBars(DistrictsID.G),
    ]);
  }
}

class TabBars extends ConsumerStatefulWidget {
  const TabBars(this.district, {super.key});
  final DistrictsID district;
  @override
  ConsumerState createState() => _TabBarsState();
}

class _TabBarsState extends ConsumerState<TabBars> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    final availableRoom = homeController.roomCalculator(
        ref.watch(homeControllerProvider).selectedDate, ref, widget.district);

    return Tab(
      // icon: const Icon(Icons.add),
      child: Column(children: [
        Text(
          widget.district.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text((availableRoom).toString())
      ]),
    );
  }
}

class CheckBoxArea extends ConsumerStatefulWidget {
  const CheckBoxArea({super.key});
  @override
  ConsumerState createState() => _CheckBoxAreaState();
}

class _CheckBoxAreaState extends ConsumerState<CheckBoxArea> {
  bool isCheckedBreakfast = false;
  bool isCheckedUK1 = false;
  bool isCheckedUK2 = false;
  bool isCheckedUK3 = false;
  bool isCheckedByCash = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(homeControllerProvider);
    return Expanded(
      child: ListView(
        children: [
          CheckboxListTile(
              title: const Text('Breakfast'),
              value: isCheckedBreakfast,
              onChanged: (bool? value) {
                ref.read(homeControllerProvider.notifier).hasBreakfast(value!);
                setState(() {
                  isCheckedBreakfast = value;
                });
              }),
          CheckboxListTile(
              title: const Text('村⺠，导游， 司机'),
              value: isCheckedUK1,
              onChanged: (bool? value) {
                ref.read(homeControllerProvider.notifier).setUKBool1(value!);
                setState(() {
                  isCheckedUK1 = value;
                });
              }),
          CheckboxListTile(
              title: const Text('股东'),
              value: isCheckedUK2,
              onChanged: (bool? value) {
                ref.read(homeControllerProvider.notifier).setUKBool2(value!);
                setState(() {
                  isCheckedUK2 = value;
                });
              }),
          CheckboxListTile(
              title: const Text('政府⼈员'),
              value: isCheckedUK3,
              onChanged: (bool? value) {
                ref.read(homeControllerProvider.notifier).setUKBool3(value!);
                setState(() {
                  isCheckedUK3 = value;
                });
              }),
          CheckboxListTile(
              title: const Text('By Cash'),
              value: isCheckedByCash,
              onChanged: (bool? value) {
                ref.read(homeControllerProvider.notifier).byCash(value!);
                setState(() {
                  isCheckedByCash = value;
                });
              }),
        ],
      ),
    );
  }
}
