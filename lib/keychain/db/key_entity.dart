class KeyEntity {
  static const TABLE_NAME = 'keys';

  final int? id;
  final String content;
  final String receptionDateTime;

  KeyEntity({this.id, required this.content, required this.receptionDateTime});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'receptionDateTime': receptionDateTime,
    };
  }
}
