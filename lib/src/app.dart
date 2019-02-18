import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app_config.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc.dart';
import 'package:pokedex_flutter/src/view/screem/main_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return BlocProvider<MainBloc>(
        bloc: MainBloc(context),
        child: MaterialApp(
          title: config.appName,
          theme: config.appTheme,
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        ));
  }
}
