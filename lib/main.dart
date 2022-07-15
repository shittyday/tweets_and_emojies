import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_and_emojies/cubit/expand_cubit.dart';
import 'package:tweets_and_emojies/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweets and emojies',
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => ExpandCubit()),
      ], child: const Home()),
    );
  }
}
