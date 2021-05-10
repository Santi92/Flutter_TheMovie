import 'package:intl/intl.dart';

class Movie {
  Movie({this.title, this.voteAverage, this.posterPath, this.releaseDate});

  String? title;
  String? posterPath;
  double? voteAverage;
  String? releaseDate;

  String getMoviePath() {
    return posterPath != null
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://cdn5.vectorstock.com/i/1000x1000/96/24/no-video-camera-sign-vector-14909624.jpg";
  }

  String getDeteString() {
    final df = new DateFormat('MMMM dd, yyyy');
    final datTime = DateTime.parse(releaseDate ?? '2021-04-07');

    print(df.format(datTime));

    return df.format(datTime);
  }
}
