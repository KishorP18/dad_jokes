import 'package:dad_jokes/domain/entities/joke.dart';
import 'package:dad_jokes/presentation/widgets/typewriter_txt.dart';
import 'package:flutter/material.dart';


class JokeWidget extends StatelessWidget {
  final Joke joke;
  const JokeWidget({Key? key,required this.joke})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,

        child: Column(
          children: [
            const SizedBox(height: 12.0,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeWriterText(
                  text: Text(joke.joke,style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black
                  ),textAlign: TextAlign.center,),
                  duration: const Duration(milliseconds: 20),
                ),
              ),
            ),

            Image.asset("assets/dad_joke.gif",

              height: MediaQuery.of(context).size.height*0.5,width: MediaQuery.of(context).size.width*0.8,fit: BoxFit.contain,),
            const SizedBox(height: 12.0,),

          ],
        ),
      ),
    );
  }
}
