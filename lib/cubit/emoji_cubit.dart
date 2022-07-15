import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_and_emojies/models/view_table.dart';
import 'package:tweets_and_emojies/repository/repository.dart';

import 'emoji_state.dart';

class EmojiCubit extends Cubit<EmojiState> {
  EmojiCubit() : super(EmojiInit());
  var repository = Repositry();

  void setEmoji({required ViewTable table}) async {
    try {
      await repository.init();
      emit(EmojiInit());
      await repository.setEmogies(table);
      emit(EmojiSuccess(table: table, update: true));
    } catch (e) {
      emit(EmojiError(message: e));
    }
  }
}
