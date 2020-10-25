import 'dart:convert';
import 'package:android_course_20_flutter/data/model/answer.dart';
import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class StackOverflowApi {
  static const STACKOVERFLOW_API_URL = 'https://api.stackexchange.com/2.2';
  final http.Client httpClient;

  StackOverflowApi ({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];

    final url = "$STACKOVERFLOW_API_URL/questions?page=1&pagesize=100&order=asc&sort=creation&tagged=Android&site=stackoverflow&filter=withbody";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting questions');
    }

    final json = jsonDecode(response.body)['items'] as List;
    json.map((question) => {
      questions.add(Question.fromJson(question))
    }).toList();

    return questions;
  }

  Future<List<Answer>> getAnswers(int questionId) async {
    List<Answer> answers = [];

    final url = "$STACKOVERFLOW_API_URL/questions/$questionId/answers?order=desc&sort=votes&site=stackoverflow&filter=withbody";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting answers');
    }

    final json = jsonDecode(response.body)['items'] as List;
    json.map((answer) => {
      answers.add(Answer.fromJson(answer))
    }).toList();

    return answers;
  }
}