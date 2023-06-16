import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/domain/usecases/get_random_joke_usecase.dart';
import 'package:dad_jokes/domain/usecases/search_jokes_usecase.dart';
import 'package:equatable/equatable.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetRandomJokeUseCase getRandomJokeUseCase;
  final SearchJokesUseCase searchJokesUseCase;
  JokeBloc(this.getRandomJokeUseCase, this.searchJokesUseCase) : super(JokeInitial()){
    on<RandomJokeRequested>((event, emit)async{
      emit(JokeLoading());
      try {
        final joke = await getRandomJokeUseCase.execute();
         emit(JokeLoaded([joke]));
      } catch (e) {
        emit(JokeError('Failed to fetch joke'));
      }
    });

    on<JokeSearchRequested>((event, emit)async{
       emit(JokeLoading());
      try {
        final jokes = await searchJokesUseCase.execute(event.searchTerm);
         emit(JokeLoaded(jokes));
      } catch (e) {
       emit(const JokeError('Failed to search jokes'));
      }
    });
  }


}
