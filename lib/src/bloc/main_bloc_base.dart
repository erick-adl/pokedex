import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pokedex_flutter/src/models/pokemon_dto.dart';
import 'package:pokedex_flutter/src/models/pokemon_model.dart';
import 'package:pokedex_flutter/src/models/type_dto.dart';
import 'package:rxdart/rxdart.dart';

abstract class MainBlocBase extends BlocBase {
  final _typeDtolistController = BehaviorSubject<List<TypeDto>>();
  final _pokemonDtoListController = BehaviorSubject<List<PokemonDto>>();
  final _pokemonController = BehaviorSubject<PokemonModel>();
  //Stream output
  Stream<List<TypeDto>> get typeDtoListControllerOut =>
      _typeDtolistController.stream;

  Stream<List<PokemonDto>> get pokemonDtoListControllerOut =>
      _pokemonDtoListController.stream;

  Stream<PokemonModel> get pokemonControllerOut => _pokemonController.stream;

//Stream update
  Function(List<TypeDto>) get typeDtoListControllerUpdate =>
      _typeDtolistController.sink.add;
  Function(List<PokemonDto>) get pokemonDtoListControllerUpdate =>
      _pokemonDtoListController.sink.add;

  Function(PokemonModel) get pokemonControllerUpdate =>
      _pokemonController.sink.add;

  Function(Object) get pokemonControllerError =>
      _pokemonController.addError;

  @override
  void dispose() {
    _typeDtolistController.close();
    _pokemonDtoListController.close();
    _pokemonController.close();
  }
}
