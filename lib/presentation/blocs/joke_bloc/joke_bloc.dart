import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/domain/usecases/get_random_joke_usecase.dart';
import 'package:dad_jokes/domain/usecases/search_jokes_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetRandomJokeUseCase getRandomJokeUseCase;
  final SearchJokesUseCase searchJokesUseCase;

  bool isFetching=false;


  JokeBloc(this.getRandomJokeUseCase, this.searchJokesUseCase) : super(JokeInitial()){
    on<RandomJokeRequested>((event, emit)async{
      emit(JokeLoading());
      try {
        final joke = await getRandomJokeUseCase.execute();
         emit(JokeLoaded([joke]));
      } catch (e) {
        emit(const JokeError('Failed to fetch joke'));
      }
    });

    on<Reset>((event, emit){
      emit(JokeInitial());
    });

    on<JokeSearchRequested>((event, emit)async{
        final currentState=state;
        int page=1;
        if(currentState is JokeLoaded){
          page=currentState.page+1;
        }


       emit(JokeLoading());
      try {
        isFetching=true;

        debugPrint("search ${event.searchTerm}");

        final jokes = await searchJokesUseCase.execute(event.searchTerm,page:page);
        if(currentState is JokeLoaded){
          debugPrint("old jokes ${  currentState.jokes.length}");
          currentState.jokes.addAll(jokes);
          debugPrint("new jokes ${  currentState.jokes.length}");
          emit(currentState.copyWith(jokes:currentState.jokes,searchTerm: event.searchTerm,page: page));
        }else{
          emit(JokeLoaded(jokes,searchTerm: event.searchTerm));
        }

         page++;

      } catch (e) {
       emit(const JokeError('Failed to search jokes'));
      }
       isFetching=false;
    });
  }


}
