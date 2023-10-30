import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lfti/pages/log_page.dart';
import 'package:lfti/pages/profile_page.dart';
import 'package:lfti/pages/routine_pages/routines_page.dart';
import 'package:lfti/pages/statistics_page.dart';

class HomePage extends StatefulWidget {
  static const String path = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;
  final List<Widget> pages = [
    const LogPage(),
    const RoutinesPage(routines: []),
    const StatisticsPage(),
    const ProfilePage(),
  ];

  @override
  initState() {
    super.initState();
    fetchRoutines();
  }

  Future<void> fetchRoutines() async {
    EasyLoading.show(status: 'Loading routines...');
    // final data = await RoutineRepository().getAll();
    EasyLoading.dismiss();
    setState(() {
      pages[1] = RoutinesPage(routines: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.power_settings_new,
          color: Colors.blueGrey,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              log('more tapped!');
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Container(child: pages[currentPageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Routines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
