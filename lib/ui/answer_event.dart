part of 'answer_bloc.dart';

abstract class AnswerEvent extends Equatable {
  const AnswerEvent();
  @override
  List<Object> get props => [];
}

class AnswerListRequested extends AnswerEvent {
  final int questionId;

  const AnswerListRequested({@required this.questionId}) : assert(questionId != null);

  @override
  List<Object> get props => [questionId];

}
