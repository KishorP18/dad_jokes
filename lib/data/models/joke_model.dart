import 'package:dad_jokes/domain/entities/joke.dart';

class JokeModel extends Joke {
  JokeModel({
    required String id,
    required String joke,
  }) : super(id: id, joke: joke);

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      id: json['id'] ?? '',
      joke: json['joke'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'joke': joke,
    };
  }
}
