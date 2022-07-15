import 'dart:async';
import 'dart:io' show Directory, Platform;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitts_emoji/common/config.dart';
import 'package:twitts_emoji/models/emojies_table.dart';
import 'package:twitts_emoji/models/tweet.dart';
import 'package:twitts_emoji/models/view_table.dart';

/// only IOS or ANDROID
class Repositry {
  Database? _database;

  /// MUST [init] FIRST after creating this object.
  ///
  /// Only IOS or ANDROID.
  ///
  /// If platfrom not IOs or Android assert exception.
  ///
  /// Asser if [database] not initialize.
  ///
  /// Enjoy.
  Repositry();

  /// Only IOS or ANDROID
  ///
  /// [database] must initialize
  ///
  /// If platfrom not IOs or Android assert exception
  ///
  ///
  Database get database {
    assert(_database != null);
    return _database!;
  }

  /// MUST [init] FIRST
  ///
  /// Only IOS or ANDROID
  Future<void> init() async {
    assert(Platform.isAndroid || Platform.isIOS);
    try {
      var databasesPath = _getPath(Platform.isAndroid
          ? await getDatabasesPath()
          : await getLibraryDirectory());
      String path = join(databasesPath, 'demo.db');
      _database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(createTweetTable);
        await db.execute(createEmojiesTable);
        await db.execute(createAllTable);
        await db.rawInsert(initTable);
        await db.rawInsert(initEmojies);
      });
    } catch (e) {
      rethrow;
    }
  }

  String _getPath(Object path) {
    if (path is Directory) {
      return path.path;
    }
    return path as String;
  }

  Future<List<Tweet>> _getTweets() async {
    try {
      var table = await database.query('Tweets');
      if (table.isEmpty) return [];
      return List.generate(
          table.length, (index) => Tweet.fromMap(table[index]));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EmojiesTable>> _getEmojies() async {
    try {
      var table = await database.query('Emojies');
      if (table.isEmpty) return [];
      return List.generate(
          table.length, (index) => EmojiesTable.fromMap(table[index]));
    } catch (e) {
      rethrow;
    }
  }

  Future<int> setEmogies(ViewTable table) async {
    var list = await _getEmojies();

    var s = list.where((element) => element.emoji == table.emojies?.last.emoji);
    if (table.emojies != null) {
      if (table.emojies!.isNotEmpty) {
        var emojies = table.emojies!
            .where((element) => element.emoji == s.first.emoji)
            .toList();
        if (emojies.length > 1) {
          for (var i = 0; i < emojies.length; i++) {
            table.emojies!.remove(emojies[i]);
            if (i == 0) {
              await database.rawDelete(
                  "DELETE FROM EmoAndTweets WHERE tweet_id = ${table.tweet.id} AND emoji_id = ${s.first.id};");
            }
          }
          return 0;
        }
      }
    }
    return database.rawInsert(
        'INSERT INTO EmoAndTweets (tweet_id, emoji_id) VALUES(${table.tweet.id},${s.first.id});');
  }

  Future<List<ViewTable>> getViewTable() async {
    try {
      /// берем твиты с бд
      var tweets = await _getTweets();

      /// берем эмодзи с бд
      var emojies = await _getEmojies();

      /// готовый список
      var viewTable = <ViewTable>[];

      /// мапа с идентификатором твита и списком эмоджи в твите
      var map = <int, List<EmojiesTable>>{};

      /// вытаскиваем все данные из 3 таблицы
      var table = await database.rawQuery('''  
      SELECT * FROM EmoAndTweets
      ''');

      /// заполняем мапу
      ///
      /// если в мапе нет id твита, создаем список, если есть заполняем список эмоджи
      for (var element in table) {
        var emojiId = element['emoji_id'] as int;
        var tweetId = element['tweet_id'] as int;

        if (map.containsKey(tweetId)) {
          map[tweetId]!
              .add(emojies.firstWhere((element) => element.id == emojiId));
        } else {
          map[tweetId] = [];
          map[tweetId]!
              .add(emojies.firstWhere((element) => element.id == emojiId));
        }
      }

      /// готовый список заполняем, если есть в мапе идентификтор твита берем список эмодзи из мапы
      ///
      /// если нет в мапе идентификтора, просто твиты добавляем
      ///
      /// сортируем твиты по id
      for (var element in tweets) {
        if (map.containsKey(element.id)) {
          viewTable.add(ViewTable(tweet: element, emojies: map[element.id]));
        } else {
          viewTable.add(ViewTable(tweet: element));
        }
        viewTable.sort(
          (a, b) => a.tweet.id!.compareTo(b.tweet.id!),
        );
      }

      return viewTable;
    } catch (e) {
      rethrow;
    }
  }
}
