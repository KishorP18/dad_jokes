import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({Key? key,required this.joke}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          joke.joke,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
