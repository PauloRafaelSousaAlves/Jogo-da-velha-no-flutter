import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/app/controller.dart';
import 'package:tic_tac_toe/app/routes.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.controller,
    this.child,
  }) : super(key: key);

  final Controller controller;
  final Widget? child;

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) => routes(settings, widget.controller),
          home: widget.child,
        );
      },
    );
  }
}
