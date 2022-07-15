import 'package:flutter/material.dart';

class TweetCardError extends StatelessWidget {
  const TweetCardError({Key? key, required this.message}) : super(key: key);
  final Object? message;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).size.width / 25,
            right: MediaQuery.of(context).size.width / 22.05,
            bottom: 10),
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
        child: Text(
          '$message',
          style: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color.fromRGBO(32, 14, 50, 1)),
        ));
  }
}
