import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/movie.dart';
import 'package:flutter_movie/search.dart';
import 'package:http/http.dart' as http;

import 'detail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Movie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> fetchDataNowPlaying() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1587604ab37eabfd99caf608963ec8e3&language=en-US&page=1"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataNowPlaying() {
    listMovieNowPlaying.clear();
    Future<String> data = fetchDataNowPlaying();
    data.then((value) async {
      Map json = jsonDecode(value);
      for (var g in json['results']) {
        Movie m = Movie.fromJson(g);
        listMovieNowPlaying.add(m);
      }
      setState(() {});
    });
  }

  Widget showNowPlaying() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listMovieNowPlaying.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network("https://image.tmdb.org/t/p/w200/" +
                  listMovieNowPlaying[index].poster),
              SizedBox(height: 10),
              Text(listMovieNowPlaying[index].judul),
              Text(listMovieNowPlaying[index].date)
            ],
          ));
        });
  }

  Future<String> fetchDataTopRated() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=1587604ab37eabfd99caf608963ec8e3&language=en-US&page=1"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataTopRated() {
    listMovieTopRated.clear();
    Future<String> data = fetchDataTopRated();
    data.then((value) async {
      Map json = jsonDecode(value);
      for (var g in json['results']) {
        Movie m = Movie.fromJson(g);
        listMovieTopRated.add(m);
      }
      setState(() {});
    });
  }

  Widget showTopRated() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listMovieTopRated.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network("https://image.tmdb.org/t/p/w200/" +
                  listMovieTopRated[index].poster),
              SizedBox(height: 10),
              Text(listMovieTopRated[index].judul),
              Text(listMovieTopRated[index].date)
            ],
          ));
        });
  }

  Future<String> fetchDataUpcoming() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=1587604ab37eabfd99caf608963ec8e3&language=en-US&page=1"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataUpcoming() {
    listMovieUpcoming.clear();
    Future<String> data = fetchDataUpcoming();
    data.then((value) async {
      Map json = jsonDecode(value);
      for (var g in json['results']) {
        Movie m = Movie.fromJson(g);
        listMovieUpcoming.add(m);
      }
      setState(() {});
    });
  }

  Widget showUpcoming() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listMovieUpcoming.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child:
              GestureDetector(onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Detail(movie_id:listMovieUpcoming[index].id ,)));
              },child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network("https://image.tmdb.org/t/p/w200/" +
                  listMovieUpcoming[index].poster),
              SizedBox(height: 10),
              Text(listMovieUpcoming[index].judul),
              Text(listMovieUpcoming[index].date)
            ],
          )));
        });
  }
  
  void initState() {
    super.initState();
    bacaDataUpcoming();
    bacaDataNowPlaying();
    bacaDataTopRated();
  }

  Widget myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('Evan Nathnaiel'),
              accountEmail: Text("evan.nathaniel0308@gmail.com"),
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=50"))),
          ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home),
              onTap: () {}),
          ListTile(
              title: new Text("Now Playing"),
              leading: new Icon(Icons.play_circle),
              onTap: () {}),
          ListTile(
              title: new Text("Top Rated"),
              leading: new Icon(Icons.star),
              onTap: () {}),
          ListTile(
              title: new Text("Upcoming"),
              leading: new Icon(Icons.movie_filter),
              onTap: () {}),
          ListTile(
              title: new Text("About"),
              leading: new Icon(Icons.person),
              onTap: () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search()));
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Container(
          child: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Upcoming',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 300),
                child: showUpcoming()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Now Playing',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 300),
                child: showNowPlaying()),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Top Rated',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 300),
                child: showTopRated()),
          ],
        ),
      ])),
      drawer: myDrawer(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
