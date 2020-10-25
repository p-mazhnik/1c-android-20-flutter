part of 'question_list_bloc.dart';

abstract class QuestionListEvent extends Equatable {
  const QuestionListEvent();

  @override
  List<Object> get props => [];
}

class QuestionListRequested extends QuestionListEvent {
  const QuestionListRequested();

}

