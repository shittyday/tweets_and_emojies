import 'package:equatable/equatable.dart';

class EmojiesTable extends Equatable {
  const EmojiesTable({this.id, required this.emoji});
  final int? id;
  final String emoji;

  factory EmojiesTable.fromMap(Map<String, Object?> map) {
    return EmojiesTable(id: map['id'] as int?, emoji: map['emoji'] as String);
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'emoji': emoji};
  }

  @override
  List<Object?> get props => [id, emoji];
}
