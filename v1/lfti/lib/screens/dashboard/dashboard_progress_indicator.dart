import 'package:flutter/material.dart';
import 'package:lfti/providers/dashboard_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DashboardProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardScreenProvider viewModel =
        Provider.of<DashboardScreenProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: FittedBox(
        child: Stack(children: [
          ///TODO: Change to NON-Stepped Progress Indicator
          CircularStepProgressIndicator(
            totalSteps: viewModel.progressViewData.total,
            currentStep: viewModel.progressViewData.current,
            stepSize: 15,
            selectedStepSize: 20,
            selectedColor: viewModel.progressViewData.color,
            unselectedColor: Colors.grey[200],
            padding: 0,
            width: 180,
            height: 180,
            roundedCap: (_, __) => true,
          ),
          Container(
            width: 180,
            height: 180,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: viewModel.progressViewData.message),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
