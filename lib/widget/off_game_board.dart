import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resouces/off_game_method.dart';

class OffGameBoard extends StatefulWidget {
  const OffGameBoard({super.key});

  @override
  State<OffGameBoard> createState() => _OffGameBoardState();
}

class _OffGameBoardState extends State<OffGameBoard> {
  void tapped(int index, RoomDataProvider roomDataProvider) {
    if (roomDataProvider.displayElements[index] == '') {
      roomDataProvider.updateData(index);
      OffGameMethod().checkWinner(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    final boardSize = screenSize.width > 600
        ? 350.0
        : (screenSize.width * 0.85).clamp(250.0, 350.0);
    final fontSize = screenSize.width > 600
        ? 50.0
        : (screenSize.width * 0.12).clamp(30.0, 50.0);
    return SizedBox(
      height: boardSize,
      width: boardSize,
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
                          color: roomDataProvider.displayElements[index] == 'O'
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
    );
  }
}
