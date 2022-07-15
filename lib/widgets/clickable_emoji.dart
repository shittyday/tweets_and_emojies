import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitts_emoji/cubit/expand_cubit.dart';
import 'package:twitts_emoji/models/emojies_table.dart';
import 'package:twitts_emoji/models/view_table.dart';

class ClickableEmoji extends StatelessWidget {
  const ClickableEmoji({Key? key, required this.emoji}) : super(key: key);
  final Emoji emoji;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          var state = context.read<ExpandCubit>().state;
          ViewTable? table = context.read<ExpandCubit>().state.table;
          var emojies = table?.emojies ?? [];
          table = table?.copyWith(emojies: table.emojies ?? []);

          emojies.add(EmojiesTable(emoji: emoji.char));
          table = ViewTable(tweet: table!.tweet, emojies: emojies);
          context.read<ExpandCubit>().value =
              state.copyWith(expanded: false, table: table);
        },
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "$emoji",
            )));
  }
}
