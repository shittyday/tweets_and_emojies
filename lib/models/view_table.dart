import 'package:twitts_emoji/models/emojies_table.dart';
import 'package:twitts_emoji/models/tweet.dart';
import 'package:equatable/equatable.dart';

class ViewTable extends Equatable {
  const ViewTable({required this.tweet, this.emojies});
  final Tweet tweet;
  final List<EmojiesTable>? emojies;

  ViewTable copyWith({Tweet? tweet, List<EmojiesTable>? emojies}) {
    return ViewTable(
        tweet: tweet ?? this.tweet, emojies: emojies ?? this.emojies);
  }

  @override
  List<Object?> get props => [tweet, emojies];
}
