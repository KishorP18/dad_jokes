import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/domain/repositories/joke_repository_domain.dart';


class SearchJokesUseCase {
  final JokeRepositoryDomain  repository;

  SearchJokesUseCase(this.repository);

  Future<List<Joke>> execute(String searchTerm,{int page=1,int limit=20}) {
    return repository.searchJokes(searchTerm,page: page,limit: limit);
  }
}
