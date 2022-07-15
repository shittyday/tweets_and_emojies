import 'package:flutter/material.dart';

import 'package:tweets_and_emojies/repository/repository.dart';
import 'package:tweets_and_emojies/widgets/custom_appbar.dart';
import 'package:tweets_and_emojies/widgets/tweet_count_card.dart';
import 'package:tweets_and_emojies/widgets/tweet_count_inherited.dart';

import 'models/view_table.dart';
import 'widgets/tweet_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final viewTableListner = ValueNotifier<List<ViewTable>>([]);

  @override
  void initState() {
    super.initState();
    _getTable();
  }

  @override
  void dispose() {
    viewTableListner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweetCountInherited(
        notifier: viewTableListner,
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromRGBO(167, 199, 236, 1), Colors.white])),
            child: Column(
              children: [
                const CustomAppBar(),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        TweetCountCard(viewTableListner: viewTableListner),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        Expanded(
                            child: ValueListenableBuilder<List<ViewTable>>(
                          valueListenable: viewTableListner,
                          builder: (context, value, child) {
                            if (value.isEmpty) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              key: UniqueKey(),
                              itemCount: viewTableListner.value.length,
                              itemBuilder: (context, index) => TweetCard(
                                table: viewTableListner.value[index],
                              ),
                            );
                          },
                        ))
                      ],
                    ))
              ],
            )));
  }

  void _getTable() async {
    var repository = Repositry();
    await repository.init();
    var table = await repository.getViewTable();
    viewTableListner.value = table;
  }
}
