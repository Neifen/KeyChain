class CreatedKeyEntity {
  final String text;
  final int timeStamp;

  CreatedKeyEntity(this.text, this.timeStamp);

  @override
  String toString() {
    return 'KeyEntity: $text with date: $timeStamp ';
  }
}
