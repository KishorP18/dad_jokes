part of 'joke_bloc.dart';

abstract class JokeState extends Equatable {
  const JokeState();
}


class JokeInitial extends JokeState {
  @override
  List<Object> get props => [];
}

class JokeLoading extends JokeState {
  @override
  List<Object> get props => [];
}

class JokeLoaded extends JokeState {
  final List<Joke> jokes;
  final String searchTerm;
  final int page;

  const JokeLoaded(this.jokes,{this.searchTerm="",this.page=1});

  JokeLoaded copyWith({List<Joke>? jokes,String? searchTerm,int? page=1}){
     return JokeLoaded(
       jokes??this.jokes,
       searchTerm: searchTerm??this.searchTerm,
       page: page??this.page
     );
  }

  @override
  List<Object> get props => [jokes,page,searchTerm];
}

class JokeError extends JokeState {
  final String message;

  const JokeError(this.message);
  @override
  List<Object> get props => [message];
}