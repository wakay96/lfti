import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/screens/activity/select_exercise_screen.dart';

class AddActivityButton extends StatelessWidget {
  final int index;
  final bool isVisible;
  AddActivityButton(this.isVisible, this.index);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
          child: Center(child: AppIcon.add),
          onTap: () {
            print('add here $index');
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    title: Center(child: Text('Choose Activity Type')),
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  child: Text('Exercise'),
                                  onPressed: () {
                                    print('add Exercise at $index');
                                    Navigator.pushNamed(
                                        context, ExerciseScreen.id);
                                  }),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  child: Text('Rest'),
                                  onPressed: () {
                                    print('add Rest at $index');
                                  }),
                            ),
                          ]),
                    ),
                  );
                });
          }),
    );
  }
}
