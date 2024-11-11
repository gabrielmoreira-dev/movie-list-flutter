import 'package:firebase_database/firebase_database.dart';
import 'package:movie_list/model/movie.dart';

class FirebaseHelper {
  static final _firebaseHelper = FirebaseHelper._internal();
  static final _db = FirebaseDatabase.instance.ref("movies");

  FirebaseHelper._internal();

  factory FirebaseHelper() => _firebaseHelper;

  Future<void> insertMovie(Movie movie) => _db.push().set(movie.toMap());

  Future<List<Movie>> getMovies() => _db
      .get()
      .then((snapshot) => (snapshot.value as Map).entries.map((obj) {
            Movie movie = Movie.fromMap(obj.value);
            movie.id = obj.key;
            return movie;
          }).toList())
      .catchError((_) => <Movie>[]);

  Future<void> deleteMovie(String id) => _db.child(id).remove();
}
