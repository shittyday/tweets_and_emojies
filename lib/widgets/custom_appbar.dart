import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_and_emojies/cubit/expand_cubit.dart';

import 'emoji_toolbar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandCubit, ExpandState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.expanded
            ? const SizedBox(
                height: 200,
                child: CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 160,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(0),
                          child: EmojiToolbar(),
                        ),
                        toolbarHeight: kToolbarHeight,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )
                    ]))
            : SizedBox(
                height: MediaQuery.of(context).padding.top,
                child: const CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 0,
                        toolbarHeight: kToolbarHeight,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )
                    ]));
      },
    );
  }
}
