part of 'question_list_bloc.dart';

abstract class QuestionListState extends Equatable {
  const QuestionListState();

  @override
  List<Object> get props => [];
}

class QuestionListInitial extends QuestionListState {}

class QuestionListLoadSuccess extends QuestionListState {
  final List<Question> questions;

  const QuestionListLoadSuccess({@required this.questions}) : assert(questions != null);

  @override
  List<Object> get props => [questions];
}

class QuestionListLoadFailure extends QuestionListState {
  final String message;

  const QuestionListLoadFailure({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

