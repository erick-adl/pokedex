import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/bloc/main_bloc_base.dart';
import 'package:pokedex_flutter/src/infra/poke_api_provider.dart';
import 'package:pokedex_flutter/src/models/pokemon_dto.dart';
import 'package:pokedex_flutter/src/models/pokemon_model.dart';
import 'package:pokedex_flutter/src/models/type_dto.dart';

class MainBloc extends MainBlocBase {
  List<TypeDto> typeDtoList;
  List<PokemonDto> pokemonDtoList;
  Map<String, List<PokemonDto>> pokemonDtoLisfetched =
      new Map<String, List<PokemonDto>>();

  PokemonModel pokemonModel;
  Map<String, PokemonModel> pokemonModelfetched =
      new Map<String, PokemonModel>();

  MainBloc(BuildContext context) {
    getListTypes();
  }

  getListTypes() async {
    typeDtoList = await PokeApiProvider().fetchAllTypes();
    typeDtoListControllerUpdate(typeDtoList);
  }

  loadListPokemons(String typeName) async {
    try {
      if (pokemonDtoLisfetched.containsKey(typeName)) {
        pokemonDtoListControllerUpdate(pokemonDtoLisfetched[typeName]);
      } else {
        pokemonDtoList = await PokeApiProvider().fetchPokemonsByType(typeName);
        if (pokemonDtoList != null || pokemonDtoList.length > 0) {
          pokemonDtoLisfetched[typeName] = pokemonDtoList;
        }
        pokemonDtoListControllerUpdate(pokemonDtoList);
      }
    } catch (e) {
      pokemonDtoListControllerUpdate(e);
    }
  }
  infoPokemonClear() async {
    try {      
        pokemonControllerUpdate(null);
      
    } catch (e) {
      pokemonControllerError(e);
    }
  }

  loadInfoPokemons(String pokemonName) async {
    try {
      if (pokemonModelfetched.containsKey(pokemonName)) {
        pokemonControllerUpdate(pokemonModelfetched[pokemonName]);
      } else {
        pokemonModel = await PokeApiProvider().fetchPokemonByName(pokemonName);
        if (pokemonModel != null) {
          pokemonModelfetched[pokemonName] = pokemonModel;
        }
        pokemonControllerUpdate(pokemonModel);
      }
    } catch (e) {
      pokemonControllerError(e);
    }
  }
}
