import 'package:flutter/material.dart';
import 'package:movie_list/model/movie.dart';
import 'package:movie_list/util/db_helper.dart';

import 'add_movie_page.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movieList = [];
  final _dbHelper = DBHelper();

  _getData() => _dbHelper.initializeDB().then((result) {
        _dbHelper.getMovies().then((result) {
          setState(() {
            _movieList = result.map(Movie.fromMap).toList();
          });
        });
      });

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _addMovie(BuildContext context) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddMoviePage()),
    );
    if (res is Movie) {
      _dbHelper.insertMovie(res);
      _getData();
    }
  }

  _seeDetails(BuildContext context, Movie movie) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie)),
    );
    if (res is int) {
      _dbHelper.deleteMovie(res);
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Movie List"),
        ),
        body: ListView.builder(
          itemCount: _movieList.length,
          itemBuilder: (_, pos) => ListItem(
            movie: _movieList[pos],
            onTap: _seeDetails,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addMovie(context),
          child: const Icon(Icons.add),
        ),
      );
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.movie,
    required this.onTap,
  });

  final Movie movie;
  final Function(BuildContext, Movie) onTap;

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
          onTap: () => onTap(context, movie),
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
