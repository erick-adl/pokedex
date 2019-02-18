import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc.dart';
import 'package:pokedex_flutter/src/models/pokemon_model.dart';
import 'package:pokedex_flutter/src/view/widget/custom_loader.dart';
import 'package:pokedex_flutter/src/view/widget/page_transformer.dart';

class PokedexPageLeft extends StatefulWidget {
  @required
  final PageVisibility pageVisibility;

  const PokedexPageLeft(this.pageVisibility);

  @override
  PokedexPageLeftState createState() {
    return new PokedexPageLeftState();
  }
}

class PokedexPageLeftState extends State<PokedexPageLeft> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 1.0,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImageBackground(),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 160, 100, 100),
              child: Container(
                child: StreamBuilder<PokemonModel>(
                    stream:
                        BlocProvider.of<MainBloc>(context).pokemonControllerOut,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data.sprites.frontDefault,
                          scale: 0.5,
                        );
                      } else {
                        return CustomLoader();
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Image _buildImageBackground() {
    return Image.asset(
      "assets/images/dex1n.png",
      fit: BoxFit.fill,
      alignment: FractionalOffset(
        0.5 + (widget.pageVisibility.pagePosition / 3),
        0.5,
      ),
    );
  }

  Widget _applyTextEffects({
    @required String text,
    @required double translationFactor,
    @required BuildContext context,
  }) {
    final double xTranslation =
        widget.pageVisibility.pagePosition * translationFactor;
    var textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: widget.pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            text,
            style: textTheme.title
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
