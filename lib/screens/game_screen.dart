import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resouces/socket_methods.dart';
import 'package:tic_tac_toe/widget/game_board.dart';
import 'package:tic_tac_toe/widget/score_board.dart';
import 'package:tic_tac_toe/utils/responsive.dart';
import 'package:tic_tac_toe/widget/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String roomName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListner(context);
    _socketMethods.updatePlayerDataListner(context);
    _socketMethods.increasePointListner(context);
    _socketMethods.endGameListner(context);
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);
    final bool isJoin = roomDataProvider.roomData['isJoin'] ?? true;

    return isJoin
        ? const WaitingLobby()
        : Scaffold(
            body: SafeArea(
              child: Responsive(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const ScoreBoard(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Center(child: const GameBoard()),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        roomDataProvider.filledBoxes == 9
                            ? ''
                            : '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
