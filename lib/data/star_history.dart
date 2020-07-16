class StarHistory {
  final String content;
  final int starCount;
  final String starCode;

  StarHistory.fromJson(Map<String, dynamic> map)
      : this.content = map['content'],
        this.starCount = map['starCount'],
        this.starCode = map['starCode'];

  Map<String, dynamic> toMap() {
    return {
      "content": this.content,
      "starCount": this.starCount,
      "starCode": this.starCode,
    };
  }
}
