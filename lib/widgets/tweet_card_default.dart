import 'package:flutter/material.dart';
import 'package:tweets_and_emojies/cubit/emoji_cubit.dart';
import 'package:tweets_and_emojies/cubit/expand_cubit.dart';
import 'package:tweets_and_emojies/models/view_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetCardDefault extends StatefulWidget {
  const TweetCardDefault({Key? key, required this.table}) : super(key: key);
  final ViewTable table;

  @override
  State<TweetCardDefault> createState() => _TweetCardDefaultState();
}

class _TweetCardDefaultState extends State<TweetCardDefault> {
  /// Разделитель
  final divider = const SizedBox(height: 5);

  /// Твиты
  late final tweetMessage = Text(
    widget.table.tweet.message,
    style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
        fontSize: 16,
        color: Color.fromRGBO(32, 14, 50, 1)),
  );

  /// Эможи
  late final emojies = Wrap(
    children: List.generate(
        widget.table.emojies!.length,
        (index) => Text(
              widget.table.emojies![index].emoji,
              style: const TextStyle(
                  fontSize: 14, decoration: TextDecoration.none),
            )),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpandCubit, ExpandState>(
        listener: (context, state) {
          /// Если id совпадают,значит мы верно соотносим эмоджи с твитом
          if (widget.table.tweet.id == state.table!.tweet.id &&
              !state.expanded) {
            context.read<EmojiCubit>().setEmoji(table: state.table!);
          }
        },
        child: GestureDetector(
          onTap: () {
            /// Развернуть список
            context.read<ExpandCubit>().value =
                ExpandState(expanded: true, table: widget.table);
          },
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 22.05,
                bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurStyle: BlurStyle.normal,
                  offset: Offset(2, 2))
            ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                divider,
                tweetMessage,
                divider,
                if (widget.table.emojies != null) emojies,
                divider
              ],
            ),
          ),
        ));
  }
}
