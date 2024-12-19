class Getnews{
  int id;
  String title;
  String body;

  Getnews({required this.id, required this.title, required this.body});

  factory Getnews.fromJson(Map<String, dynamic> json) {
    return Getnews(id: json['id'], title: json['title'], body: json['body']);
  }
}