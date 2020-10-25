import 'package:android_course_20_flutter/data/remote/stackoverflow_api.dart';
import 'package:android_course_20_flutter/data/repository/question_repository.dart';
import 'package:android_course_20_flutter/ui/answer_bloc.dart';
import 'package:android_course_20_flutter/ui/question_list_bloc.dart';
import 'package:android_course_20_flutter/ui/question_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  final QuestionRepository questionRepository = QuestionRepository(
    stackOverflowApi: StackOverflowApi(
      httpClient: http.Client(),
    ),
  );
  runApp(MyApp(questionRepository: questionRepository));
}

class MyApp extends StatelessWidget {
  final QuestionRepository questionRepository;

  MyApp({Key key, @required this.questionRepository})
      : assert(questionRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter StackOverflow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionListBloc>(
            create: (context) =>
                QuestionListBloc(questionRepository: questionRepository)
                  ..add(QuestionListRequested()),
          ),
          BlocProvider<AnswerBloc>(
            create: (context) =>
                AnswerBloc(questionRepository: questionRepository),
          )
        ],
        child: QuestionListPage(),
      ),
    );
  }
}
