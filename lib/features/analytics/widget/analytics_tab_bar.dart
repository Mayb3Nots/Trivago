import 'package:flutter/material.dart';

class AnalyticsTabBar extends StatelessWidget {
  const AnalyticsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
        tabs: [Text('Financial'), Text('Operations'), Text('Descriptive')]);
  }
}
