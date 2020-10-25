import 'package:android_course_20_flutter/data/model/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AnswerWidget extends StatelessWidget {
  final Answer answer;

  const AnswerWidget({Key key, @required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Score: ${answer.score}",
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Html(
                  data: "${answer.body}",
                  // style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
