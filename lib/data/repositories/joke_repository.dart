
import 'package:dad_jokes/data/datasources/joke_remote_data_source.dart';
import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/domain/repositories/joke_repository_domain.dart';

class JokeRepository implements JokeRepositoryDomain{
  final JokeRemoteDataSource remoteDataSource;

  JokeRepository(this.remoteDataSource);

  Future<Joke> getRandomJoke() {
    return remoteDataSource.fetchRandomJoke();
  }

  Future<List<Joke>> searchJokes(String searchTerm) {
    return remoteDataSource.searchJokes(searchTerm);
  }
}
