import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app_config.dart';
import 'package:pokedex_flutter/src/app.dart';



void main() {
  var configuredApp = new AppConfig(
    appName: 'Pokedex Flutter',
    flavorName: 'development',
    apiBaseUrl: "https://pokeapi.co/api/v2/",
    child: new App(),
  );

  runApp(configuredApp);
}