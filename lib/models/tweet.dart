class Tweet {
  const Tweet({this.id, required this.message});
  final int? id;
  final String message;

  factory Tweet.fromMap(Map<String, Object?> map) {
    return Tweet(id: map['id'] as int?, message: map['message'] as String);
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'message': message};
  }
}
