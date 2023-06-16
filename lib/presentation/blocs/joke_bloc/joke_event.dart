part of 'joke_bloc.dart';

abstract class JokeEvent extends Equatable {
  const JokeEvent();
}


class RandomJokeRequested extends JokeEvent {
  @override
  List<Object?> get props =>[];
}

class JokeSearchRequested extends JokeEvent {
  final String searchTerm;

  const JokeSearchRequested(this.searchTerm);


  @override
  List<Object?> get props =>[searchTerm];
}



class Reset extends JokeEvent {
  @override
  List<Object?> get props =>[];
}