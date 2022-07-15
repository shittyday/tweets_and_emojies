import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:twitts_emoji/widgets/clickable_emoji.dart';

class EmojiToolbar extends StatelessWidget {
  const EmojiToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Список всеъ эможт
    final emojies = Emoji.all();

    /// Разделитель
    final divider = Divider(
      height: 10,
      color: Colors.white.withOpacity(0),
    );

    /// Татйтл
    const title = Text(
      'Twitter emoji',
      style: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
          fontSize: 15,
          color: Colors.white),
    );

    /// Список эможи
    final emojiesCard = Column(
      children: [
        divider,
        title,
        divider,
        Expanded(
            child: ListView.builder(
          itemCount: emojies.length ~/ 8,
          itemBuilder: (context, index) {
            return Row(
              children: List.generate(
                  8,
                  (i) => Expanded(
                      child: ClickableEmoji(emoji: emojies[index * 8 + i]))),
            );
          },
        )),
        divider
      ],
    );

    return Container(
        height: 150,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: MediaQuery.of(context).size.width / 25,
          right: MediaQuery.of(context).size.width / 22.05,
        ),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(131, 136, 175, 0.34),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(134, 103, 242, 0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer)
            ],
            borderRadius: BorderRadius.circular(12)),
        child: emojiesCard);
  }
}
