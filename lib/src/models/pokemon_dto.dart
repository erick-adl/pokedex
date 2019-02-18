class PokemonDto {
  String name;
  String url;

  PokemonDto({
    this.name,
    this.url,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) => new PokemonDto(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
