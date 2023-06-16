import 'package:dad_jokes/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'domain/entities/joke.dart';
import 'presentation/pages/joke_page.dart';

class Routes{
  static const home="/";
  static const searchScreen="/search_screen";
  static const jokeScreen="/joke_widget";

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (context)=>const HomePage());
        case jokeScreen:
        final joke=settings.arguments as Joke;
        return MaterialPageRoute(builder: (context)=> JokePage(joke: joke));
      default:
        return MaterialPageRoute(builder: (context)=>const HomePage());

    }
  }
}