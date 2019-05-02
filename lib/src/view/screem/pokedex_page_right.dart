import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app_config.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc.dart';
import 'package:pokedex_flutter/src/models/pokemon_model.dart';
import 'package:pokedex_flutter/src/view/widget/custom_loader.dart';
import 'package:pokedex_flutter/src/view/widget/page_transformer.dart';
import 'package:share/share.dart';

class PokedexPageRight extends StatefulWidget {
  @required
  final PageVisibility pageVisibility;

  @required
  final BuildContext context;

  const PokedexPageRight(this.pageVisibility, this.context);

  @override
  PokedexPageRightState createState() {
    return new PokedexPageRightState();
  }
}

class PokedexPageRightState extends State<PokedexPageRight> {
  List<Widget> buildInfos(PokemonModel pokemonModel) {
    List<Widget> infos = new List<Widget>();
    infos.add(Text("Name: ${pokemonModel.name}"));
    infos.add(Text("Height: ${pokemonModel.height}"));
    infos.add(Text("Weight: ${pokemonModel.weight}"));
    if (pokemonModel.abilities.length > 0) {
      infos.add(Text("Abilities:"));
      for (var item in pokemonModel.abilities) {
        infos.add(Text("${item.ability.name}",
            style: AppConfig.of(widget.context).appTheme.textTheme.body1));
      }
    }
    return infos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 1.0,
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: FloatingActionButton(
            onPressed: () {
              _shareInfo(context);
            },
            child: Icon(Icons.share),
            elevation: 3.0,
            backgroundColor: Colors.red,
          ),
        ),
        body: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImageBackground(),
              _buildContainerInfos(),
            ],
          ),
        ),
      ),
    );
  }

  _shareInfo(BuildContext context) async {
    var pokemon = BlocProvider.of<MainBloc>(context).pokemonModel;
    final url = await _createDynamicLink(pokemon.name);
    if (pokemon != null) {
      var buffer = new StringBuffer();
      buffer.write("\nName: ${pokemon.name}");
      buffer.write("\nHeight: ${pokemon.height}");
      buffer.write("\nWeight: ${pokemon.weight}");
      if (pokemon.abilities.length > 0) {
        buffer.write("\nAbilities:");
        for (var item in pokemon.abilities) {
          buffer.write("\n${item.ability.name}");
        }
      }
      buffer.write("\n\nView in: ${url.toString()}");
      Share.share(buffer.toString());
    }    
  }

  Future<Uri> _createDynamicLink(String name,{bool short = true}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      domain: 'pokedexflutter.page.link',
      link: Uri.parse("https://podekex.com/?pdx=$name"),
      androidParameters: AndroidParameters(
        packageName: 'com.erick.pokedexflutter',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.erick.pokedexflutter',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }
    print(url);
    return url;
  }

  Padding _buildContainerInfos() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 160, 70, 110),
      child: StreamBuilder<PokemonModel>(
          stream:
              BlocProvider.of<MainBloc>(widget.context).pokemonControllerOut,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildInfos(snapshot.data),
                ),
              ));
            } else {
              return CustomLoader();
            }
          }),
    );
  }

  Image _buildImageBackground() {
    return Image.asset(
      "assets/images/dex2n.png",
      fit: BoxFit.fill,
      alignment: FractionalOffset(
        0.5 + (widget.pageVisibility.pagePosition / 3),
        0.5,
      ),
    );
  }
}
