import 'dart:convert';

import 'package:dad_jokes/data/models/joke_model.dart';
import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



class JokeRemoteDataSource {
  static const String apiUrl = 'https://icanhazdadjoke.com/';

  Future<Joke> fetchRandomJoke() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      debugPrint("${json}");
      return JokeModel(id: json['id'], joke: json['joke']);
    } else {
      throw Exception('Failed to fetch joke');
    }
  }

  Future<List<Joke>> searchJokes(String searchTerm,{int page=1,int limit=20}) async {
    final response = await http.get(
      Uri.parse(apiUrl + 'search?term=$searchTerm&page=$page&&limit=$limit'),
      headers: {'Accept': 'application/json'},
    );
    debugPrint("request ${response.request}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<dynamic> jokesJson = json['results'];
      debugPrint("${jokesJson}");
      return jokesJson
          .map((jokeJson) => JokeModel(id: jokeJson['id'], joke: jokeJson['joke']))
          .toList();
    } else {
      throw Exception('Failed to search jokes');
    }
  }
}
