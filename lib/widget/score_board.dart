import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    RoomDataProvider dataProvider = Provider.of<RoomDataProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    // Responsive sizing
    final isSmallScreen = screenSize.width < 600;
    final verticalPadding = isSmallScreen ? 20.0 : 40.0;
    final nameFontSize = isSmallScreen ? 20.0 : 25.0;
    final pointsFontSize = isSmallScreen ? 14.0 : 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Column(
              children: [
                Text(
                  dataProvider.player1.nickname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  dataProvider.player1.points.toInt().toString(),
                  style: TextStyle(fontSize: pointsFontSize),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Flexible(
            child: Column(
              children: [
                Text(
                  dataProvider.player2.nickname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  dataProvider.player2.points.toInt().toString(),
                  style: TextStyle(fontSize: pointsFontSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
