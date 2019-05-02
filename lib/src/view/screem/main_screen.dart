import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app_config.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc.dart';
import 'package:pokedex_flutter/src/models/pokemon_dto.dart';
import 'package:pokedex_flutter/src/models/type_dto.dart';
import 'package:pokedex_flutter/src/view/screem/pokedex_screen.dart';
import 'package:pokedex_flutter/src/view/tile/custom_expansion_tile.dart';
import 'package:pokedex_flutter/src/view/widget/custom_loader.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool selectedItemType = false;
  final GlobalKey<CustomExpansionTileState> keyTileType = new GlobalKey();
  final GlobalKey<CustomExpansionTileState> keyTilePokemon = new GlobalKey();
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
     Future.delayed(Duration(seconds: 1), () {
        _retrieveDynamicLink();
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(Duration(seconds: 1), () {
        _retrieveDynamicLink();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _buildImageBackground("assets/images/home.png"),
                  streamBuilderListType(),
                ],
              ),
              WillPopScope(
                onWillPop: () {
                  gotoPageListType();
                },
                child: Stack(
                  children: <Widget>[
                    _buildImageBackground("assets/images/home2.png"),
                    streamBuilderListPokemon()
                  ],
                ),
              )
            ],
          )),
    ));
  }

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.retrieveDynamicLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      if (deepLink.authority == "podekex.com") {
        for (var item in deepLink.queryParameters.keys) {
          if (item == "pdx") {
            final namePok = deepLink.queryParameters[item];
            print(namePok);
            BlocProvider.of<MainBloc>(context).loadInfoPokemons(namePok);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PokedexScreen()),
            );
          }
        }
      }
    }
  }

  streamBuilderListType() {
    return StreamBuilder(
      stream: BlocProvider.of<MainBloc>(context).typeDtoListControllerOut,
      builder: (context, AsyncSnapshot<List<TypeDto>> snap) {
        if (!snap.hasData) {
          return CustomLoader();
        } else if (snap.hasError) {
          return _buildErrorMessage(context, "Error connecting to server...");
        } else {
          return buildContainerDecorator(_buildListViewType(snap));
        }
      },
    );
  }

  streamBuilderListPokemon() {
    return StreamBuilder(
      stream: BlocProvider.of<MainBloc>(context).pokemonDtoListControllerOut,
      builder: (context, AsyncSnapshot<List<PokemonDto>> snap) {
        if (!snap.hasData) {
          return CustomLoader();
        } else if (snap.hasError) {
          return _buildErrorMessage(context, "Error connecting to server...");
        } else if (snap.data.length == 0) {
          return _buildErrorMessage(context, "No information");
        } else {
          return buildContainerDecorator(_buildListViewPokemon(snap));
        }
      },
    );
  }

  Widget _buildListViewType(AsyncSnapshot<List<TypeDto>> snap) {
    return ListView.builder(
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        return _buildTileTypeItem(snap.data[index]);
      },
    );
  }

  Widget _buildListViewPokemon(AsyncSnapshot<List<PokemonDto>> snap) {
    return ListView.builder(
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        return _buildTilePokemonItem(snap.data[index]);
      },
    );
  }

  Widget _buildErrorMessage(BuildContext context, String text) {
    return Center(
        child:
            Text(text, style: AppConfig.of(context).appTheme.textTheme.title));
  }

  Widget _buildImageBackground(String imageAddress) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAddress),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTileTypeItem(TypeDto typeDto) {
    return InkWell(
      onTap: () {
        BlocProvider.of<MainBloc>(context).pokemonDtoListControllerUpdate(null);
        BlocProvider.of<MainBloc>(context).loadListPokemons(typeDto.name);
        gotoPageListPokemon();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12, blurRadius: 1, offset: Offset(3, 3)),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.arrow_right, color: Colors.red[300]),
                Text(
                  typeDto.name,
                  style: AppConfig.of(context).appTheme.textTheme.title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTilePokemonItem(PokemonDto pokemonDto) {
    return InkWell(
      onTap: () {
        BlocProvider.of<MainBloc>(context).loadInfoPokemons(pokemonDto.name);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PokedexScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12, blurRadius: 1, offset: Offset(3, 3)),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.arrow_right, color: Colors.red[300]),
                Text(
                  pokemonDto.name,
                  style: AppConfig.of(context).appTheme.textTheme.title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainerDecorator(Widget child) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 150, 20, 40),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87, width: 1.0),
            color: Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12, blurRadius: 1, offset: Offset(3, 3)),
            ],
          ),
          child: child),
    );
  }

  gotoPageListType() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }

  gotoPageListPokemon() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }
}
