import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/app.dart';
import 'package:tic_tac_toe/app/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Controller ctrl = Controller();
  ctrl();

  runApp(
    App(
      controller: ctrl,
    ),
  );
}
