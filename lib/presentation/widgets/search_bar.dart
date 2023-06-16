

import 'package:dad_jokes/presentation/blocs/joke_bloc/joke_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                // Dispatch JokeSearchRequested event
                context.read<JokeBloc>().add(JokeSearchRequested(value));
              },
              decoration:const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              // Dispatch RandomJokeRequested event
              context.read<JokeBloc>().add(RandomJokeRequested());
            },
            child: Text('Random Joke'),
          ),
        ],
      ),
    );
  }
}