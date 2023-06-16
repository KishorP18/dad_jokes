
import 'package:dad_jokes/domain/usecases/get_random_joke_usecase.dart';
import 'package:dad_jokes/domain/usecases/search_jokes_usecase.dart';
import 'package:dad_jokes/presentation/blocs/joke_bloc/joke_bloc.dart';
import 'package:dad_jokes/presentation/widgets/joke_card.dart';
import 'package:dad_jokes/presentation/widgets/joke_list.dart';
import 'package:dad_jokes/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dad_jokes/injector.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokeBloc(
          getIt<GetRandomJokeUseCase>(),
          getIt<SearchJokesUseCase>()
      ),
      child: const _HomePage(),
    );
  }
}



class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {

  @override
  void initState(){
    super.initState();
    BlocProvider.of<JokeBloc>(context).add(RandomJokeRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dad Jokes'),
      ),
      body: Column(
        children: const [
          SearchBar(),
          Expanded(child: JokeList()),
        ],
      ),
    );
  }
}

