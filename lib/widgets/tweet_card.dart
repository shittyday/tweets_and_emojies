import 'package:flutter/material.dart';
import 'package:twitts_emoji/cubit/emoji_cubit.dart';
import 'package:twitts_emoji/cubit/emoji_state.dart';
import 'package:twitts_emoji/models/view_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitts_emoji/repository/repository.dart';
import 'package:twitts_emoji/widgets/tweer_error_card.dart';
import 'package:twitts_emoji/widgets/tweet_card_default.dart';
import 'package:twitts_emoji/widgets/tweet_count_inherited.dart';

class TweetCard extends StatefulWidget {
  const TweetCard({Key? key, required this.table}) : super(key: key);
  final ViewTable table;

  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    void _getTable() async {
      var repository = Repositry();
      await repository.init();
      await repository
          .getViewTable()
          .then((value) => TweetCountInherited.of(context).value = value);
    }

    return BlocProvider(
        create: (_) => EmojiCubit(),
        child: BlocBuilder<EmojiCubit, EmojiState>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, state) {
            if (state is EmojiLoding) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is EmojiError) {
              return TweetCardError(message: state.message);
            }
            if (state is EmojiSuccess) {
              if (state.table!.tweet.id == widget.table.tweet.id) {
                _getTable();
                return TweetCardDefault(table: state.table!);
              }
            }
            return TweetCardDefault(table: widget.table);
          },
        ));
  }
}
