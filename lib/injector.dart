
import 'package:dad_jokes/data/datasources/joke_remote_data_source.dart';
import 'package:dad_jokes/data/repositories/joke_repository.dart';
import 'package:dad_jokes/domain/usecases/get_random_joke_usecase.dart';
import 'package:dad_jokes/domain/usecases/search_jokes_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt=GetIt.instance;
void setupInjector(){


  getIt.registerLazySingleton<JokeRemoteDataSource>(()=>JokeRemoteDataSource());
  getIt.registerLazySingleton<JokeRepository>(() => JokeRepository(
      getIt.get<JokeRemoteDataSource>()
  ));
  getIt.registerLazySingleton<GetRandomJokeUseCase>(() => GetRandomJokeUseCase(
    getIt.get<JokeRepository>()
  ));

  getIt.registerLazySingleton<SearchJokesUseCase>(() => SearchJokesUseCase(
      getIt.get<JokeRepository>()
  ));


}