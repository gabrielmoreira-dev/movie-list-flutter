import 'package:flutter/material.dart';
import 'package:movie_list/model/movie.dart';

class AddMoviePage extends StatelessWidget {
  AddMoviePage({super.key});

  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _studioController = TextEditingController();
  final _rateList = [1, 2, 3, 4, 5];
  var _rate = 1;

  _addMovie(BuildContext context) {
    final movie = Movie(
      title: _nameController.text,
      rate: _rate,
      year: int.parse(_yearController.text),
      studio: _studioController.text,
    );
    Navigator.pop(context, movie);
  }

  _backHome(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Add Movie"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter the name:",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter the year:",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _studioController,
                decoration: const InputDecoration(
                  hintText: "Enter the studio:",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownMenu(
                onSelected: (value) => _rate = value ?? 1,
                hintText: "Enter the rate",
                width: MediaQuery.of(context).size.width,
                dropdownMenuEntries: _rateList
                    .map(
                      (value) => DropdownMenuEntry(
                        value: value,
                        label: value.toString(),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _addMovie(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: const Text("Add Movie"),
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
              ),
            ],
          ),
        ),
      );
}
