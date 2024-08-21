import 'package:flutter/material.dart';

import '../ember_quest.dart';

class Timer extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;
  const Timer({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Text(
            '03:00',
            style: TextStyle(
              color: whiteTextColor,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
