import 'dart:developer';

import 'package:flutter/material.dart';

class PageContaner extends StatelessWidget {
  const PageContaner({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              log('more tapped!');
            },
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Center(child: body),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  log('Log Tapped');
                },
                icon: const Icon(Icons.timer)),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  log('Routines Tapped');
                },
                icon: const Icon(Icons.fitness_center)),
            label: 'Routines',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  log('Statistics Tapped');
                },
                icon: const Icon(Icons.bar_chart)),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  log('Profile Tapped');
                },
                icon: const Icon(Icons.person)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
