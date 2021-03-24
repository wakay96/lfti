import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/repository/i_repository.dart';

abstract class ScreenProvider extends ChangeNotifier {
  late IRepository repo;
  late Map<String, dynamic>? args;

  void initialize(BuildContext context) {
    repo = GetIt.instance<IRepository>();
    if (ModalRoute.of(context)!.settings.arguments != null)
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    else
      args = null;
  }
}
