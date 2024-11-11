class Movie {
  String? id;
  final String title;
  final int rate;
  final int year;
  final String studio;

  Movie({
    required this.title,
    required this.rate,
    required this.year,
    required this.studio,
  });

  Movie.withId({
    required this.id,
    required this.title,
    required this.rate,
    required this.year,
    required this.studio,
  });

  Movie.fromMap(dynamic o)
      : id = o["id"].toString(),
        title = o["title"],
        rate = o["rate"],
        year = o["year"],
        studio = o["studio"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["rate"] = rate;
    map["year"] = year;
    map["studio"] = studio;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
