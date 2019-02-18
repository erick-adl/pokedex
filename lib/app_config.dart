import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  AppConfig(
      {@required this.appName,
      @required this.flavorName,
      @required this.apiBaseUrl,
      @required Widget child,
      })
      : super(child: child);

  final String appName;
  final String flavorName;
  final String apiBaseUrl;

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  final appTheme = ThemeData(
    backgroundColor: Color.fromARGB(13, 0, 0, 0),
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 59, 177, 221),
    accentColor: Color.fromARGB(255, 255, 255, 255),
    cardColor: Color.fromARGB(90, 111, 225, 98),
    
    textTheme: TextTheme(
      title: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
      subtitle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
      body1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind',
          color: Color.fromARGB(255, 0, 0, 0)),
      body2: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Hind',
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0)),
    ),
  );
}
