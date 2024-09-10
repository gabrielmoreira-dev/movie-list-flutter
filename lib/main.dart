import 'package:flutter/material.dart';
import 'package:movie_list/view/home_page.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: "Movie List",
    home: HomePage(),
  );
}
