import 'package:filmer/got.dart';
import 'package:flutter/material.dart';

class EpisodePage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage myImage;
  EpisodePage({this.episodes, this.myImage});
  BuildContext _context;

  showSummary(String summary) {
    showDialog(
        context: _context,
        builder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: Text(summary),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Hero(
              tag: "ava",
              child: CircleAvatar(
                backgroundImage: NetworkImage(myImage.medium),
              ),
            ),
            Text(
              ' All Episodes',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            showSummary(episodes[index].summary);
          },
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  episodes[index].image.original,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        episodes[index].name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 0.0,
                    top: 0.0,
                    child: Container(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${episodes[index].season} - ${episodes[index].number}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        itemCount: episodes.length,
      ),
    );
  }
}
