class Question {
  String title;
  int score;
  String body;
  String ownerName;
  int id;

  Question({this.title, this.score, this.body, this.ownerName, this.id});

  Question.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
    score = json['score'];
    id = json['question_id'];
    ownerName = json['owner']['display_name'];
  }

  Map<String, dynamic> toDbJson() {
    var map = <String, dynamic> {
      'title': title,
      'id': id,
      'score': score,
      'body': body,
      'owner_name': ownerName,
    };
    return map;
  }

  Question.fromDbJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
    score = json['score'];
    id = json['id'];
    ownerName = json['owner_name'];
  }
}

