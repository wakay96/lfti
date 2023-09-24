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
  List<Widget> pages = [Container()];

  @override
  void initState() {
    EasyLoading.show(status: 'Loading...');
    final List<Routine> routines = Repository().fetchAllRoutines();

    pages = [
      const LogPage(),
      RoutinesPage(routines),
      const StatisticsPage(),
      const ProfilePage(),
    ];

    super.initState();
    EasyLoading.dismiss();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return pages[0];
      case 1:
        return pages[1];
      case 2:
        return pages[2];
      case 3:
        return pages[3];
      default:
    }
    return pages[index];
  }

  String getPageTitle(int index) {
    switch (index) {
      case 0:
        return AppPage.log.title;
      case 1:
        return AppPage.routines.title;
      case 2:
        return AppPage.statistics.title;
      case 3:
        return AppPage.profile.title;
      default:
    }
    return pages[index].toString();
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                getPageTitle(currentPageIndex),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(child: getPage(currentPageIndex)),
          ],
        ),
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
