import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  _deleteMovie(BuildContext context) => Navigator.pop(context, movie.id);

  _backHome(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Year: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${movie.year}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Studio: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    movie.studio,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Rate: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${movie.rate}/5",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _deleteMovie(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: const Text("Delete"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _backHome(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: const Text("Back"),
              )
            ],
          ),
        ),
      );
}
