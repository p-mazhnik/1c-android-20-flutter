import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:android_course_20_flutter/data/remote/stackoverflow_api.dart';
import 'package:meta/meta.dart';

class QuestionRepository {
  final StackOverflowApi stackOverflowApi;

  QuestionRepository({@required this.stackOverflowApi})
      : assert(stackOverflowApi != null);

  Future<List<Question>> getAllQuestions() async {
    return this.stackOverflowApi.getQuestions();
  }

}

