class Answer {
  String body;
  int score;
  int questionId;
  int id;

  Answer({this.body, this.score, this.questionId, this.id});

  Answer.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    score = json['score'];
    questionId = json['question_id'];
    id = json['answer_id'];
  }
}

