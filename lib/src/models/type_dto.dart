class TypeDto {
  String name;
  String url;
  bool selected = false;

  TypeDto({
    this.name,
    this.url,
  });

  factory TypeDto.fromJson(Map<String, dynamic> json) => new TypeDto(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
