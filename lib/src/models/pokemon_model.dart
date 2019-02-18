// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromJson(jsonString);

import 'dart:convert';

PokemonModel pokemonModelFromJson(String str) {
    final jsonData = json.decode(str);
    return PokemonModel.fromJson(jsonData);
}

String pokemonModelToJson(PokemonModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PokemonModel {
    String name;
    int height;
    int weight;
    List<AbilityElement> abilities;
    Sprites sprites;
    List<TypeElement> types;

    PokemonModel({
        this.name,
        this.height,
        this.weight,
        this.abilities,
        this.sprites,
        this.types,
    });

    factory PokemonModel.fromJson(Map<String, dynamic> json) => new PokemonModel(
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        abilities: new List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromJson(x))),
        sprites: Sprites.fromJson(json["sprites"]),
        types: new List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "weight": weight,
        "abilities": new List<dynamic>.from(abilities.map((x) => x.toJson())),
        "sprites": sprites.toJson(),
        "types": new List<dynamic>.from(types.map((x) => x.toJson())),
    };
}

class AbilityElement {
    AbilityAbility ability;

    AbilityElement({
        this.ability,
    });

    factory AbilityElement.fromJson(Map<String, dynamic> json) => new AbilityElement(
        ability: AbilityAbility.fromJson(json["ability"]),
    );

    Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
    };
}

class AbilityAbility {
    String name;

    AbilityAbility({
        this.name,
    });

    factory AbilityAbility.fromJson(Map<String, dynamic> json) => new AbilityAbility(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Sprites {
    String frontDefault;

    Sprites({
        this.frontDefault,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => new Sprites(
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
    };
}

class TypeElement {
    int slot;
    TypeType type;

    TypeElement({
        this.slot,
        this.type,
    });

    factory TypeElement.fromJson(Map<String, dynamic> json) => new TypeElement(
        slot: json["slot"],
        type: TypeType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}

class TypeType {
    String name;
    String url;

    TypeType({
        this.name,
        this.url,
    });

    factory TypeType.fromJson(Map<String, dynamic> json) => new TypeType(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
