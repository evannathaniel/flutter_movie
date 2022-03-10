import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/main.dart';

import 'package:http/http.dart' as http;

import 'movie.dart';




class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  String _txtcari = 'a';
  Future<String> fetchData() async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=1587604ab37eabfd99caf608963ec8e3&query="+_txtcari.replaceAll(' ', '+')));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    listMovie.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var g in json['results']) {
        
        Movie gs = Movie.fromJson(g);
        listMovie.add(gs);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Widget showMovie(List Movie) {
    if (listMovie.length > 0) {
      return ListView.builder(
          itemCount: listMovie.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network("https://image.tmdb.org/t/p/w200/" +
                  listMovie[index].poster),
              SizedBox(height: 10),
              Text(listMovie[index].judul),
              Text(listMovie[index].date)
              ],
            ));
          });
    } else {
      return Text("Tidak ada data Movie");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()))),
        title: Text('List Movie'),
      ),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    labelText: 'Seach by title:',
                  ),
                  onChanged: (value) {
                    _txtcari = value;
                    bacaData();
                  },
                )),
            Container(
                height: MediaQuery.of(context).size.height - 200,
                child: showMovie(listMovie)),
          ],
        )
      ]),
      
    );
  }
}
