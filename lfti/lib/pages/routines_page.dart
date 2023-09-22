import 'package:flutter/widgets.dart';
import 'package:lfti/pages/page.dart';

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  @override
  Widget build(BuildContext context) {
    return const PageContaner(
      title: 'Routines',
      body: Center(
        child: Text('Routines Page'),
      ),
    );
  }
}
