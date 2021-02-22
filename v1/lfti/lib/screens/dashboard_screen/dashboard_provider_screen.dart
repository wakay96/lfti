import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'dashboard_screen.dart';

class DashboardProviderScreen extends StatelessWidget {
  static String id = "DashboardScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (BuildContext context) => DashboardProvider(),
      child: DashboardScreen(),
    );
  }
}
