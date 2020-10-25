import 'package:android_course_20_flutter/data/model/question.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                question.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              // isThreeLine: true,
              dense: true,
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Score: ${question.score}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Author: ${question.ownerName}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
