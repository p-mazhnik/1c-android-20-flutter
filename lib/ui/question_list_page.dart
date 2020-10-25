import 'dart:async';

import 'package:android_course_20_flutter/ui/question_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/question_widget.dart';

class QuestionListPage extends StatefulWidget {
  State<QuestionListPage> createState() => _QuestionListPageState();
}


class _QuestionListPageState extends State<QuestionListPage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Stackoverflow')),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<QuestionListBloc>(context).add(
            QuestionListRequested(),
          );
          return _refreshCompleter.future;
        },
        child: BlocListener<QuestionListBloc, QuestionListState>(
          listener: (context, state) {
            if (state is QuestionListLoadFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failure'),
                ),
              );
            }
            if (state is QuestionListLoadSuccess || state is QuestionListLoadFailure) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<QuestionListBloc, QuestionListState>(
            builder: (context, state) {
              if (state is QuestionListInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is QuestionListLoadFailure) {
                return Center(
                  child: ListView(
                    children: [
                      Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.red),
                    )],
                  ),
                );
              }

              if (state is QuestionListLoadSuccess) {
                if (state.questions.isEmpty) {
                  return Center(
                    child: Text('no questions'),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return QuestionWidget(question: state.questions[index]);
                      },
                      itemCount: state.questions.length,
                    ),
                  ),
                );
              }
              return Center(
                child: Text('no questions'),
              );
            },
          ),
        ),
      ),
    );
  }
}

