import 'package:flutter/material.dart';
import 'package:twitts_emoji/models/view_table.dart';

class TweetCountCard extends StatelessWidget {
  const TweetCountCard({Key? key, required this.viewTableListner})
      : super(key: key);
  final ValueNotifier<List<ViewTable>> viewTableListner;
  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).size.width / 25,
            right: MediaQuery.of(context).size.width / 22.05),
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
        child: ValueListenableBuilder<List<ViewTable>>(
          valueListenable: viewTableListner,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              count = value.where((element) => element.emojies != null).length;
            }
            return Text(
              'Количество твитов с эмоджи $count',
              style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  color: Colors.black),
            );
          },
        ));
  }
}
