import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';

class OffScoreBoard extends StatefulWidget {
  const OffScoreBoard({super.key});

  @override
  State<OffScoreBoard> createState() => _OffScoreBoardState();
}

class _OffScoreBoardState extends State<OffScoreBoard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    // Responsive sizing
    final isSmallScreen = screenSize.width < 600;
    final verticalPadding = isSmallScreen ? 20.0 : 30.0;
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
                  roomDataProvider.player1.nickname,
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
                  roomDataProvider.player1.points.toInt().toString(),
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
                  roomDataProvider.player2.nickname,
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
                  roomDataProvider.player2.points.toInt().toString(),
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
