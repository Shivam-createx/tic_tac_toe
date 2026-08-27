import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resouces/game_method.dart';

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              GameMethod().clearBoard(context);
            },
            child: Text('Play Again!'),
          ),
        ],
      );
    },
  );
}
