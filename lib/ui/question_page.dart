import 'dart:async';

import 'package:android_course_20_flutter/ui/question_list_bloc.dart';
import 'package:android_course_20_flutter/ui/widgets/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'answer_bloc.dart';

class QuestionPage extends StatefulWidget {
  final int id;

  const QuestionPage({Key key, this.id}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState(id: id);
}

class _QuestionPageState extends State<QuestionPage> {
  final int id;
  Completer<void> _refreshCompleter;

  _QuestionPageState({this.id});

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnswerBloc>(context).add(
      AnswerListRequested(questionId: id),
    );
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Stackoverflow')),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<AnswerBloc>(context).add(
            AnswerListRequested(questionId: id),
          );
          return _refreshCompleter.future;
        },
        child: BlocListener<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswersLoadSuccess || state is AnswersLoadFailure) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<QuestionListBloc, QuestionListState>(
            builder: (context, state) {
              final question = (state as QuestionListLoadSuccess)
                  .questions
                  .firstWhere((question) => question.id == id);

              return Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Scrollbar(
                  child: ListView(children: [
                    SizedBox(height: 16),
                    Padding(
                      child: Text(
                          '${question.title}',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      padding: EdgeInsets.only(left: 24.0, right: 20.0),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      child: Html(
                          data: question.body,
                      ),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    ),
                    BlocBuilder<AnswerBloc, AnswerState>(
                        builder: (context, answerState) {
                      if (answerState is AnswersInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (answerState is AnswersLoadSuccess) {
                        if (answerState.answers.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: Center(
                              child: Text('no answers'),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return AnswerWidget(
                                  answer: answerState.answers[index]);
                            },
                            itemCount: answerState.answers.length,
                          )
                        );
                      }
                      return Center(
                        child: Text('no answers'),
                      );
                    })
                ])
                )
              );
            },
          ),
        ),
      ),
    );
  }
}
