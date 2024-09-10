import 'package:flutter/material.dart';
import 'package:movie_list/model/movie.dart';

import 'add_movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movieList = [];

  @override
  void initState() {
    _movieList = [
      Movie(title: "Joker", rate: 5, year: 2019, studio: "Warner Bros"),
      Movie(title: "Joker", rate: 5, year: 2019, studio: "Warner Bros"),
      Movie(title: "Joker", rate: 5, year: 2019, studio: "Warner Bros"),
      Movie(title: "Joker", rate: 5, year: 2019, studio: "Warner Bros"),
      Movie(title: "Joker", rate: 4, year: 2019, studio: "Warner Bros"),
    ];
    super.initState();
  }

  _addMovie(BuildContext context) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddMoviePage()),
    );
    if (res is Movie) {
      setState(() {
        _movieList.add(res);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Movie List"),
        ),
        body: ListView.builder(
          itemCount: _movieList.length,
          itemBuilder: (_, pos) => ListItem(movie: _movieList[pos]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addMovie(context),
          child: const Icon(Icons.add),
        ),
      );
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.movie});

  final Movie movie;

  Color _getColor() {
    switch (movie.rate) {
      case 5:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getColor(),
            child: Text(
              movie.rate.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(movie.title),
          subtitle: Text("${movie.studio} | ${movie.year}"),
        ),
      );
}
