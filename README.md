# Pokedex flutter

Pokedex é um aplicativo para consulta de pokemon utilizando a API pokeapi.co e desenvolvido em Flutter.
Para quem não conhece Flutter, documentação ao final do README:
* [Api pokeapi](https://pokeapi.co)

### Estrutura de projeto:

├── app_config.dart  --> Configuraçãoes iniciais padrão  
├── main.dart  
└── src  
&nbsp;├── app.dart  
&nbsp;&nbsp;    ├── bloc --> Flutter é "reactive programming" | “business logic components.” | BLoc  
&nbsp;&nbsp;    │   ├── main_bloc_base.dart  
&nbsp;&nbsp;    │   └── main_bloc.dart  
&nbsp;&nbsp;    ├── infra  
&nbsp;&nbsp;    │   └── poke_api_provider.dart  
&nbsp;&nbsp;    ├── models  
&nbsp;&nbsp;    │   ├── pokemon_dto.dart  
&nbsp;&nbsp;    │   ├── pokemon_model.dart  
&nbsp;&nbsp;    │   └── type_dto.dart  
&nbsp;&nbsp;    └── view  
&nbsp;&nbsp;&nbsp;        ├── screem  
&nbsp;&nbsp;&nbsp;        │   ├── main_screen.dart  
&nbsp;&nbsp;&nbsp;        │   ├── pokedex_page_left.dart  
&nbsp;&nbsp;&nbsp;        │   ├── pokedex_page_right.dart  
&nbsp;&nbsp;&nbsp;        │   └── pokedex_screen.dart  
&nbsp;&nbsp;&nbsp;        ├── tile  
&nbsp;&nbsp;&nbsp;        │   ├── custom_expansion_tile.dart  
&nbsp;&nbsp;&nbsp;        │   └── expansion_tile_item.dart  
&nbsp;&nbsp;&nbsp;        └── widget  
&nbsp;&nbsp;&nbsp;&nbsp;            ├── custom_alert.dart  
&nbsp;&nbsp;&nbsp;&nbsp;            ├── custom_loader.dart  
&nbsp;&nbsp;&nbsp;&nbsp;            └── page_transformer.dart   

## Foram usadas algumas bibliotecas nativas e outras de terceiros:
dependencies:  
   &nbsp;&nbsp;flutter:  
   &nbsp;&nbsp;&nbsp;&nbsp;sdk: flutter  
   &nbsp;&nbsp;&nbsp;&nbsp;bloc_pattern: ^1.5.1  
   &nbsp;&nbsp;&nbsp;&nbsp;rxdart: ^0.20.0  
   &nbsp;&nbsp;&nbsp;&nbsp;http: ^0.12.0+1  
   &nbsp;&nbsp;&nbsp;&nbsp;flutter_launcher_icons: ^0.7.0  
   &nbsp;&nbsp;&nbsp;&nbsp;share: ^0.6.0+1  

## NOTA: Faça um Fork do projeto e utiliza o CI/CD Codemagic
* [Codemagic](https://codemagic.io/)


## Build beautiful native apps in record time

Flutter is Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.

### Documentation

**Main site: [flutter.io][]**
* [Install](https://flutter.io/get-started/install/)
* [Get started](https://flutter.io/get-started/)
* [API documentation](https://docs.flutter.io/)
* [Changelog](https://github.com/flutter/flutter/wiki/Changelog)
* [How to contribute](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md)

## Fast development

Flutter's <em>hot reload</em> helps you quickly
and easily experiment, build UIs, add features, and fix
bugs. Experience sub-second reload times,
without losing state, on
emulators, simulators, and hardware for iOS
and Android.

