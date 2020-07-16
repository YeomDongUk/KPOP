class Board {
  final int uid;
  final String typeCode;
  final String title;
  final String content;
  final String newYn;

  Board.fromJson(Map map)
      : this.uid = map['uid'],
        this.typeCode = map['typeCode'],
        this.title = map['title'],
        this.content = map['content'],
        this.newYn = map['newYn'];

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "typeCode": this.typeCode,
      "title": this.title,
      "content": this.content,
      "newYn": this.newYn,
    };
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
