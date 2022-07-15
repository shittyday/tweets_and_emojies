import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_and_emojies/models/view_table.dart';

class ExpandState extends Equatable {
  const ExpandState({required this.expanded, this.table});
  final ViewTable? table;
  final bool expanded;

  ExpandState copyWith({ViewTable? table, bool? expanded}) {
    return ExpandState(
        expanded: expanded ?? this.expanded, table: table ?? this.table);
  }

  @override
  List<Object?> get props => [table, expanded];
}

class ExpandCubit extends Cubit<ExpandState> {
  ExpandCubit() : super(const ExpandState(expanded: false));

  set value(ExpandState value) => emit(value);
  ExpandState get value => state;
}
