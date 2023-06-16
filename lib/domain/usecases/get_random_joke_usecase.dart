import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/domain/repositories/joke_repository_domain.dart';


class GetRandomJokeUseCase {
  final JokeRepositoryDomain repository;

  GetRandomJokeUseCase(this.repository);

  Future<Joke> execute() {
    return repository.getRandomJoke();
  }
}
