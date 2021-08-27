class CreatedKeyEntity {
  final String text;
  final DateTime dateTime;

  CreatedKeyEntity(this.text, this.dateTime);

  @override
  String toString() {
    return 'KeyEntity: $text with date: $dateTime ';
  }
}
