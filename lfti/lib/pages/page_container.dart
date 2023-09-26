import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/pages/log_page.dart';
import 'package:lfti/pages/profile_page.dart';
import 'package:lfti/pages/routine_pages/routines_page.dart';
import 'package:lfti/pages/statistics_page.dart';
import 'package:lfti/services/repository.dart';

class HomePage extends StatefulWidget {
  static const String path = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = AppPage.routines.index;
  List<Widget> pages = [];
  List<Routine> routines = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    EasyLoading.show(status: 'Loading...');
    // await Future.delayed(const Duration(seconds: 3));
    routines = Repository().fetchAllRoutines();

    setState(() {
      pages = [
        const LogPage(),
        const RoutinesPage(),
        const StatisticsPage(),
        const ProfilePage(),
      ];
    });

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          items: AppPage.values.map((pageInfo) {
            return BottomNavigationBarItem(
              icon: pageInfo.icon,
              label: pageInfo.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}
