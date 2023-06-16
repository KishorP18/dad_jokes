import 'package:dad_jokes/presentation/blocs/joke_bloc/joke_bloc.dart';
import 'package:dad_jokes/presentation/widgets/joke_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class JokeList extends StatelessWidget {
  const JokeList({Key? key}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeBloc, JokeState>(
      builder: (context, state) {
        if (state is JokeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JokeLoaded) {
          final jokes = state.jokes;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return JokeCard(joke: joke);
            },
          );
        } else if (state is JokeError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}