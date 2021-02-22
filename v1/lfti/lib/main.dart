import 'package:flutter/material.dart';
import 'package:lfti/screens/dashboard_screen/dashboard_provider_screen.dart';
import 'package:lfti/services/app_manager.dart';

void main() {
  AppManager().registerServices();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'lfti',
        initialRoute: DashboardProviderScreen.id,
        routes: {
          DashboardProviderScreen.id: (context) => DashboardProviderScreen(),
        });
  }
}
