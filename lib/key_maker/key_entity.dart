import 'dart:async';

class KeyEntity {
  final String text;
  final DateTime dateTime;

  KeyEntity(this.text, this.dateTime);

  @override
  String toString() {
    return 'KeyEntity: $text with date: $dateTime ';
  }
}
