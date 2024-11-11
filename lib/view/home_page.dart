import 'package:flutter/material.dart';
import 'package:movie_list/model/movie.dart';
import 'package:movie_list/util/db_helper.dart';
import 'package:movie_list/util/firebase_helper.dart';

import 'add_movie_page.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFirebaseEnabled = false;
  List<Movie> _movieList = [];
  final _dbHelper = DBHelper();
  final _firebaseHelper = FirebaseHelper();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() => _isFirebaseEnabled ? _getExternalData() : _getInternalData();

  _getExternalData() => _firebaseHelper.getMovies().then(
        (value) => setState(() => _movieList = value),
      );

  _getInternalData() => _dbHelper.initializeDB().then((result) {
        _dbHelper.getMovies().then((result) {
          setState(() {
            _movieList = result.map(Movie.fromMap).toList();
          });
        });
      });

  _addMovie(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddMoviePage()),
      ).then((res) {
        if (res is Movie) {
          _isFirebaseEnabled ? _addExternalData(res) : _addInternalData(res);
        }
      });

  _addExternalData(Movie movie) =>
      _firebaseHelper.insertMovie(movie).then((_) => _getData());

  _addInternalData(Movie movie) =>
      _dbHelper.insertMovie(movie).then((_) => _getData());

  _seeDetails(BuildContext context, Movie movie) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie)),
      ).then((res) {
        if (res is String) {
          _isFirebaseEnabled
              ? _deleteExternalData(res)
              : _deleteInternalData(res);
        }
      });

  _deleteExternalData(String id) =>
      _firebaseHelper.deleteMovie(id).then((_) => _getData());

  _deleteInternalData(String id) =>
      _dbHelper.deleteMovie(id).then((_) => _getData());

  _onStorageChange(bool value) {
    setState(() => _isFirebaseEnabled = value);
    _getData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Movie List"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("External storage"),
                  Switch(
                      value: _isFirebaseEnabled, onChanged: _onStorageChange),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _movieList.length,
                itemBuilder: (_, pos) => ListItem(
                  movie: _movieList[pos],
                  onTap: _seeDetails,
                ),
              ),
            ),
          ],
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
