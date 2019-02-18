import 'package:test_api/test_api.dart';
import 'package:pokedex_flutter/src/infra/poke_api_provider.dart';
import 'package:pokedex_flutter/src/models/pokemon_model.dart';
import 'package:pokedex_flutter/src/models/type_dto.dart';

main() {
  group("Poke api", () {
    test("fetch type list", () async {
      final provider = PokeApiProvider();
      List<TypeDto> result = await provider.fetchAllTypes();
      for (var item in result) {
        print(item.name);
      }
      expect(result != null, true);
    });

    test("fetch pokemons by type", () async {
      final provider = PokeApiProvider();
      var result = await provider.fetchPokemonsByType("ice");
      for (var item in result) {
        print(item.name);
      }
      expect(result != null, true);
    });

    test("fetch pokemon by name", () async {
      final provider = PokeApiProvider();
      PokemonModel result = await provider.fetchPokemonByName("ditto");
      print(result.name);
      expect(result != null, true);
    });
  });
}
