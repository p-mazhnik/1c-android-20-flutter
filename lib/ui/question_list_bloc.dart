import 'dart:async';

import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:meta/meta.dart';
import 'package:android_course_20_flutter/data/repository/question_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_list_event.dart';
part 'question_list_state.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  final QuestionRepository questionRepository;

  QuestionListBloc({@required this.questionRepository}) : assert(questionRepository != null), super(QuestionListInitial());

  @override
  Stream<QuestionListState> mapEventToState(
    QuestionListEvent event,
  ) async* {
    try {
      final List<Question> questions = await questionRepository.getAllQuestions();
      yield QuestionListLoadSuccess(questions: questions);
    } catch (_) {
      yield QuestionListLoadFailure();
    }
  }
}

