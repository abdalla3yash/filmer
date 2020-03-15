import 'package:filmer/got.dart';
import 'package:flutter/material.dart';
import 'episode_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      'http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes';

  GOT got;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEpisodes();
  }

  fetchEpisodes() async {
    var res = await http.get(url);
    var decoded = jsonDecode(res.body);
    got = GOT.fromJson(decoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filmer',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchEpisodes();
        },
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget myBody() {
    return got == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Hero(
                  tag: "ava",
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(got.image.original),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  got.name,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "runtime: ${got.runtime.toString()}  minutes",
                  style: TextStyle(fontSize: 18.0, color: Colors.green),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(got.summary),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EpisodePage(
                                  episodes: got.eEmbedded.episodes,
                                  myImage: got.image,
                                )));
                  },
                  color: Colors.amber,
                  child: Text(
                    'All Episodes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          );
  }
}
