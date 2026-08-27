import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resouces/socket_methods.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.tappedListner(context);
    super.initState();
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    final isPlayerTurn =
        roomDataProvider.roomData['turn'] != null &&
        roomDataProvider.roomData['turn']['socketID'] ==
            _socketMethods.socketClient.id;

    // Calculate responsive board size
    final boardSize = screenSize.width > 600
        ? 350.0
        : (screenSize.width * 0.85).clamp(250.0, 350.0);
    final fontSize = screenSize.width > 600
        ? 50.0
        : (screenSize.width * 0.12).clamp(30.0, 50.0);

    return SizedBox(
      height: boardSize,
      width: boardSize,
      child: AbsorbPointer(
        absorbing: !isPlayerTurn,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElements[index],
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 40,
                            color:
                                roomDataProvider.displayElements[index] == 'O'
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
