
import 'package:dad_jokes/domain/usecases/get_random_joke_usecase.dart';
import 'package:dad_jokes/domain/usecases/search_jokes_usecase.dart';
import 'package:dad_jokes/presentation/blocs/joke_bloc/joke_bloc.dart';
import 'package:dad_jokes/presentation/pages/joke_page.dart';
import 'package:dad_jokes/presentation/widgets/joke_list.dart';
import 'package:dad_jokes/presentation/widgets/joke_widget.dart';
import 'package:dad_jokes/presentation/widgets/retry_widget.dart';
import 'package:dad_jokes/presentation/widgets/search_btn.dart';
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
   final _textController=TextEditingController();
   final _isSearchBarOpen=ValueNotifier<int>(0);
   final FocusNode _focusNode=FocusNode();
  @override
  void initState(){
    super.initState();
    BlocProvider.of<JokeBloc>(context).add(RandomJokeRequested());


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:   SearchBar(
              width: 400,

              height: 50,
              onChanged: (String val){

                context.read<JokeBloc>().add(JokeSearchRequested(_textController.value.text));
              },
              rtl:true,
              focusNode: _focusNode,


              textController: _textController,

              onSuffixTap: (){
                print("tatapp");
                BlocProvider.of<JokeBloc>(context).add(Reset());
              },

              searchBarOpen: (int val){

                _isSearchBarOpen.value=val;
                if(val==0){
                  _focusNode.unfocus();
                }
              },

              onSubmitted: (String val){
                context.read<JokeBloc>().add(JokeSearchRequested(val));
              },

            ),
          ),
        ),
        body:ValueListenableBuilder(
          valueListenable: _isSearchBarOpen,
          builder: (context,value,child){
            if(value==0){
              return  const _Card();
            }else{
              return const JokeList();
            }
          },

        ),

      ),
    );
  }
}



class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeBloc,JokeState>(
        builder: (context,state){
          if(state is JokeInitial){
            BlocProvider.of<JokeBloc>(context).add(RandomJokeRequested());

          }else if(state is JokeLoaded&&state.jokes.isNotEmpty){
            return JokeWidget(joke: state.jokes[0]);

          }else if(state is JokeLoaded&&state.jokes.isEmpty||state is JokeError){
            return RetryWidget(
              onRetry: ()=>BlocProvider.of<JokeBloc>(context).add(RandomJokeRequested()),
            );
          }


          return const Center(child: CircularProgressIndicator(),);
        }

    );
  }
}


