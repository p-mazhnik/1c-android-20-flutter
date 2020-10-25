part of 'answer_bloc.dart';

abstract class AnswerState extends Equatable {
  const AnswerState();

  @override
  List<Object> get props => [];
}

class AnswersInitial extends AnswerState {}

class AnswersLoadSuccess extends AnswerState {
  final List<Answer> answers;

  const AnswersLoadSuccess({@required this.answers}) : assert(answers != null);

  @override
  List<Object> get props => [answers];
}

class AnswersLoadFailure extends AnswerState {}