import 'package:equatable/equatable.dart';
import 'package:tweets_and_emojies/models/view_table.dart';

abstract class EmojiState extends Equatable {
  const EmojiState();
  @override
  List<Object?> get props => [];
}

class EmojiInit extends EmojiState {}

class EmojiLoding extends EmojiState {}

class EmojiSuccess extends EmojiState {
  const EmojiSuccess({required this.table, this.update = false});
  final ViewTable? table;
  final bool update;
  @override
  List<Object?> get props => [table, update];
}

class EmojiError extends EmojiState {
  const EmojiError({required this.message});
  final Object? message;
  @override
  List<Object?> get props => [message];
}
