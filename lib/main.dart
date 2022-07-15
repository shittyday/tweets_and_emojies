import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitts_emoji/cubit/expand_cubit.dart';
import 'package:twitts_emoji/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitters emoji',
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => ExpandCubit()),
      ], child: const Home()),
    );
  }
}
