class Answer {
  String body;
  int score;
  int questionId;
  int id;

  Answer({this.body, this.score, this.questionId, this.id});

  Answer.fromJson(Map<String, dynamic> json) {
    // TODO
    body = json['body'];
  }
}

