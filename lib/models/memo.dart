class Memo{
  final String id;
  final String message;
  final String author;
  final DateTime createdAt;
  final List<String> tags;

  Memo ({required this.id, required this.message, required this.author, required this.createdAt, required this.tags});

  factory Memo.fromJson(Map<String, dynamic> json){
    return Memo(
      id: json['id'],
      message: json['message'],
      author: json['author'],
      createdAt: DateTime.parse(json['created_at']),
      tags: List<String>.from(json['tags'] ?? [])
    );
  }
}