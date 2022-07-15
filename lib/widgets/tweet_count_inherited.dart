import 'package:flutter/cupertino.dart';
import 'package:twitts_emoji/models/view_table.dart';

/// Класс который вниз по дереву проталкивает ValueNotifier
///
/// Таким образом мы можем смотреть, когда изменилась таблица
///
class TweetCountInherited
    extends InheritedNotifier<ValueNotifier<List<ViewTable>>> {
  const TweetCountInherited(
      {super.key, required super.child, required super.notifier});
  static ValueNotifier<List<ViewTable>> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TweetCountInherited>()!
        .notifier!;
  }
}
