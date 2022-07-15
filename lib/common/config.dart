import 'package:emojis/emoji.dart';

const initTable =
    '''INSERT INTO Tweets(message) VALUES("Sure, the France region of France. Otherwise its tasty and I think the public opinion than expected."),
    ("Viktor Orban, an absurd attempt to leave a usage-based business model like AWS by Elon Musk responds…."),
    ("Morning Nearly all the breakup fee? Is there was key in a history book ON IT well shit .... what they?"),
    ("This is unpopular podcast fun with Twitter responds to Monday! as retail investors have been offline a?"),
    ("So long is on Kindle - they might be A thread. 1/10 Ok good pt here on DVD and Under Fortunate Star…?"),
    ("Currently reading the breakup fee? Is there had their wheaties today praising the beginning of both?"),
    ("The a Ponzi scheme July 7, Link? You gonna get that and neglecting an unintended side effect of having!"),
    ("The for startups in office was a state-sponsored Christian adoption lawsuit alleging the third book in?"),
    ("Tennessee judges dismiss adoption agency refused to… There's a startup is that data is behold… workout?")
    ''';

const createTweetTable =
    'CREATE TABLE Tweets (id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT NOT NULL);';
const createEmojiesTable =
    'CREATE TABLE Emojies (id INTEGER PRIMARY KEY AUTOINCREMENT, emoji TEXT NOT NULL);';
const createAllTable =
    'CREATE TABLE EmoAndTweets (emoji_id INTEGER,tweet_id INTEGER, FOREIGN KEY (emoji_id)  REFERENCES Emojies (id),FOREIGN KEY (tweet_id)  REFERENCES Tweets (id));';

String get initEmojies {
  final emojies = Emoji.all();
  var string = '';
  for (var element in emojies) {
    string = '$string ("${element.char}"),';
  }
  string = string.substring(0, string.length - 1);
  return 'INSERT INTO Emojies(emoji) VALUES $string';
}
