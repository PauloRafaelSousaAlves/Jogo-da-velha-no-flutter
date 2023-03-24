import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  Controller();

  Future initialization(BuildContext? context) async {
    await Future.delayed(const Duration(seconds: 3));
  }

  call() async {
    initialization(null);
  }
}
