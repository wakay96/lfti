import 'package:flutter/material.dart';

import 'package:lfti/shared/header.dart';

class StatisticsPage extends StatelessWidget {
  static const String path = 'StatisticsPage';
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(title: 'Statistics'),
          Text(
            'Workout History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Total Workouts: 0',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Total Time: 0 minutes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Total Calories Burned: 0',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
