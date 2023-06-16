import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/presentation/widgets/joke_widget.dart';
import 'package:flutter/material.dart';

class JokePage extends StatelessWidget {
final Joke joke;
  const JokePage({Key? key,required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(

           ),
           body: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 24),
             child: JokeWidget(joke: joke),
           ));
  }
}
