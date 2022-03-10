import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/main.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'movie.dart';

class Detail extends StatefulWidget {
  final int movie_id;
  Detail({Key? key, required this.movie_id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<Detail> {
  var poster;
  var backdrop;
  var judul;
  var overview;
  var date;
  var budget;
  var key;
late YoutubePlayerController _controller;
  Future<String> fetchData() async {
    final response = await http.get(Uri.parse("http://api.themoviedb.org/3/movie/" +
        this.widget.movie_id.toString() +
        "?api_key=1587604ab37eabfd99caf608963ec8e3&append_to_response=videos"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    listMovieUpcoming.clear();
    Future<String> data = fetchData();
    data.then((value) async {
      Map json = jsonDecode(value);
      backdrop = json['backdrop_path'];
      judul = json['original_title'];
      overview = json['overview'];
      date = json['release_date'];
      budget = json['budget'].toString();
      key = json['videos']['results'][0]['key'];
       _controller= YoutubePlayerController(
        initialVideoId: key,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Widget tampilData() {
    return Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Stack(children: <Widget>[
            Image.network("https://image.tmdb.org/t/p/w500/" + backdrop),
            Padding(padding: EdgeInsets.only(top: 100,left: 170),
              child: Text(judul,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow)),
            )
          ]),
          Padding(padding: EdgeInsets.all(30),child:
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          )),
          Text('Overview',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(overview),
          Text('Released Date',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(date),
          Text('Budget',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(budget),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
          title: const Text('Detail Target'),
        ),
        body: ListView(children: <Widget>[
          tampilData(),
        ]));
  }
}
