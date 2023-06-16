import 'package:dad_jokes/domain/entities/joke.dart';

abstract class JokeRepositoryDomain {
  Future<Joke> getRandomJoke();
  Future<List<Joke>> searchJokes(String searchTerm);
}
