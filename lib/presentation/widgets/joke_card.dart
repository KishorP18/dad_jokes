import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/router.dart';
import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({Key? key,required this.joke}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, Routes.jokeScreen,arguments: joke);
        },
        child:
        Card(
          elevation: 2.0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child:  Text(
              joke.joke,

              style: const TextStyle(
                fontSize: 16.0,

              ),
            ),
          ),
        ),
      ),
    );
  }
}

