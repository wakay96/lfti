import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final username;
  CustomAppBar({@required this.username});

  @override
  _CustomAppBarState createState() => _CustomAppBarState(username);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String username;
  _CustomAppBarState(this.username);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: implement navbar drawer
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text(
        "Hello $username!",
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}
