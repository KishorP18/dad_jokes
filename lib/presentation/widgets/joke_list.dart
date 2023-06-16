import 'package:dad_jokes/presentation/blocs/joke_bloc/joke_bloc.dart';
import 'package:dad_jokes/presentation/widgets/joke_card.dart';
import 'package:dad_jokes/presentation/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class JokeList extends StatefulWidget {
  const JokeList({Key? key}):super(key: key);

  @override
  State<JokeList> createState() => _JokeListState();
}

class _JokeListState extends State<JokeList> {
  late ScrollController  _scrollController;

  @override
  void initState(){
    super.initState();
    _scrollController=ScrollController();

  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeBloc, JokeState>(
      builder: (context, state) {
        if(state is JokeLoaded&&state.jokes.isEmpty){
         return Center(
           child: Text("Oops!No result!",style: Theme.of(context).textTheme.caption,),
         );
        }else if (state is JokeLoaded) {
          final jokes = state.jokes;
          return ListView.builder(
            itemCount: jokes.length,
            controller: _scrollController..addListener(() {
              if (_scrollController.offset ==
                  _scrollController.position.maxScrollExtent &&
                  !BlocProvider.of<JokeBloc>(context).isFetching) {
                BlocProvider.of<JokeBloc>(context).add(JokeSearchRequested(state.searchTerm));
              }
            }),
            itemBuilder: (context, index) {

              return JokeCard(joke: jokes[index]);
            },
          );
        } else if (state is JokeError) {
          return RetryWidget(onRetry: ()=>   BlocProvider.of<JokeBloc>(context).add(JokeSearchRequested("")));

        }
          return const Center(child: CircularProgressIndicator());

      },
    );
  }
}