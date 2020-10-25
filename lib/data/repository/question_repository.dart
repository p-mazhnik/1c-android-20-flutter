import 'package:android_course_20_flutter/data/local/dao/question_dao.dart';
import 'package:android_course_20_flutter/data/model/answer.dart';
import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:android_course_20_flutter/data/remote/stackoverflow_api.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class QuestionRepository {
  final StackOverflowApi stackOverflowApi;
  final questionDao = QuestionDao();

  QuestionRepository({@required this.stackOverflowApi})
      : assert(stackOverflowApi != null);

  Future<List<Question>> getAllQuestions() async {
    try {
      List<Question> questions = await this.stackOverflowApi.getQuestions();
      // save to db if not web
      if (kIsWeb) {
        return questions;
      }
      await questionDao.addQuestions(questions);
    } catch (e) {
      print(e.toString());
      if (kIsWeb) {
        throw e;
      }
    }
    return questionDao.getAllQuestions();
  }

  Future<List<Answer>> getAnswers(int questionId) async {
    return this.stackOverflowApi.getAnswers(questionId);
  }

}

