import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/main_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';
import 'package:tic_tac_toe/utils/responsive.dart';
import 'package:tic_tac_toe/widget/off_game_board.dart';
import 'package:tic_tac_toe/widget/off_score_board.dart';

class OffGameScreen extends StatefulWidget {
  static const String routeName = '/offGameScreen';

  const OffGameScreen({super.key});

  @override
  State<OffGameScreen> createState() => _OffGameScreenState();
}

class _OffGameScreenState extends State<OffGameScreen> {
  String turn(RoomDataProvider roomDataProvider) {
    if (roomDataProvider.filledBoxes == 9) return '';

    final activePlayer = roomDataProvider.symbol == 'X'
        ? roomDataProvider.player1.nickname
        : roomDataProvider.player2.nickname;

    return '$activePlayer\'s turn';
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
        elevation: 0,
        backgroundColor: bgcolor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.logout_outlined),
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainScreen.routeName,
                  (value) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'logout', child: Text('Logout')),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Responsive(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const OffScoreBoard(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(child: const OffGameBoard()),
                ),
                const SizedBox(height: 25),
                Text(turn(roomDataProvider), style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
