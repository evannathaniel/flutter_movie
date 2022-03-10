


class Movie{
  int id;
  String judul;
  String overview;
  String poster;
  String backdrop;
  String date;
  
  Movie({required this.id,required this.judul,required this.overview,
  required this.poster,required this.backdrop,required this.date});
  
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        judul: json['original_title'],
        overview: json['overview'],
        poster:json['poster_path'],
        backdrop: json['backdrop_path'],
        date:json['release_date'].toString());
  }
}

var listMovieUpcoming = <Movie>[];
var listMovieNowPlaying = <Movie>[];
var listMovieTopRated = <Movie>[];
var listMovie = <Movie>[];