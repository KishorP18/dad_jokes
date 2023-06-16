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

  const JokeLoaded(this.jokes);
  @override
  List<Object> get props => [jokes];
}

class JokeError extends JokeState {
  final String message;

  const JokeError(this.message);
  @override
  List<Object> get props => [message];
}