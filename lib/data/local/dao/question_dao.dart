import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

class QuestionDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> addQuestion(Question question) async {
    final db = await dbProvider.database;
    return db.insert(
        DatabaseProvider.QUESTION_TABLE, question.toDbJson(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> addQuestions(List<Question> questions) async {
    final db = await dbProvider.database;
    Batch batch = db.batch();
    questions.forEach((question) {
        batch.insert(
          DatabaseProvider.QUESTION_TABLE, question.toDbJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      }
    );
    await batch.commit(noResult: true);
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(DatabaseProvider.QUESTION_TABLE);

    List<Question> questions = result.isNotEmpty
        ? result.map((item) => Question.fromDbJson(item)).toList()
        : [];
    return questions;
  }
}

