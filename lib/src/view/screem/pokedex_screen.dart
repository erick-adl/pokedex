import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc.dart';
import 'package:pokedex_flutter/src/view/screem/pokedex_page_left.dart';
import 'package:pokedex_flutter/src/view/screem/pokedex_page_right.dart';
import 'package:pokedex_flutter/src/view/widget/page_transformer.dart';

class PokedexScreen extends StatelessWidget {
  @required
  final _pageController = PageController(viewportFraction: 0.95);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<MainBloc>(context).infoPokemonClear();
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: SizedBox.fromSize(
            size: const Size.fromHeight(500.0),
            child: PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return PageView(
                  controller: _pageController,
                  children: <Widget>[
                    PokedexPageLeft(
                        visibilityResolver.resolvePageVisibility(0)),
                    PokedexPageRight(
                        visibilityResolver.resolvePageVisibility(1), context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
