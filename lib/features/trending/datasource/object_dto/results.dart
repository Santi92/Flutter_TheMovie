class Result {
  Result({
    this.title,
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.adult,
    this.backdropPath,
    this.voteCount,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.popularity,
    this.mediaType,
  });

  String? title;
  bool? video;
  double? voteAverage;
  String? overview;
  String? releaseDate;
  bool? adult;
  String? backdropPath;
  int? voteCount;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  double? popularity;
  String? mediaType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        voteCount: json["vote_count"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate,
        "adult": adult,
        "backdrop_path": backdropPath,
        "vote_count": voteCount,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "popularity": popularity,
        "media_type": mediaType,
      };
}
