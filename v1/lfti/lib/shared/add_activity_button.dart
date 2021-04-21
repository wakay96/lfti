import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/screens/activity/add_activity_screen.dart';

class AddActivityButton extends StatefulWidget {
  final bool isVisible;
  final int index;
  late final Function(int index, Activity newActivity) addActivity;
  AddActivityButton(this.isVisible, this.index, this.addActivity);

  @override
  _AddActivityButtonState createState() => _AddActivityButtonState();
}

class _AddActivityButtonState extends State<AddActivityButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<dynamic> result = [];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).cardColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: InkWell(
            child: Center(child: AppIcon.add),
            onTap: () async {
              await showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text('Choose Activity Type')),
                      content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  child: Text('Exercise'),
                                  onPressed: () async {
                                    try {
                                      Navigator.pop(context);
                                      var data = await Navigator.pushNamed(
                                              context, AddActivityScreen.id)
                                          as List<Activity>;
                                      data.forEach((element) {
                                        widget.addActivity(
                                            widget.index, element);
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  child: Text('Rest'),
                                  onPressed: () {
                                    print('add Rest at');
                                  }),
                            ),
                          ]),
                    );
                  }).then((value) {
                if (value != null) {
                  setState(() {
                    result = value;
                  });
                }
              });
            }),
      ),
    );
  }
}
