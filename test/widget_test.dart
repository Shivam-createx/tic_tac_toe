import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resouces/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

void main() {
  test('socket URL uses a local dev endpoint', () {
    expect(SocketClient.socketUrl, contains('://'));
    expect(SocketClient.socketUrl, contains('3000'));
  });

  test('provider saves players from room data payload', () {
    final provider = RoomDataProvider();

    provider.updateRoomData({
      'isJoin': true,
      'players': [
        {
          'nickname': 'Alice',
          'socketId': 'abc',
          'points': 0,
          'playerType': 'X',
        },
        {'nickname': 'Bob', 'socketId': 'def', 'points': 0, 'playerType': 'O'},
      ],
    });

    expect(provider.player1.nickname, 'Alice');
    expect(provider.player2.nickname, 'Bob');
  });

  test('provider starts a new offline game with a clean board and score', () {
    final provider = RoomDataProvider();

    provider.startNewOfflineGame('Alice', 'Bob');
    provider.updateData(0);
    provider.updatePoints('X');
    provider.startNewOfflineGame('Carol', 'Dan');

    expect(provider.hasOfflineGame, isTrue);
    expect(provider.player1.nickname, 'Carol');
    expect(provider.player2.nickname, 'Dan');
    expect(provider.player1.points, 0);
    expect(provider.player2.points, 0);
    expect(provider.displayElements, everyElement(''));
    expect(provider.filledBoxes, 0);
    expect(provider.symbol, 'X');
  });

  test('provider keeps the offline game available after leaving it', () {
    final provider = RoomDataProvider();

    provider.startNewOfflineGame('Alice', 'Bob');
    provider.updateData(4);

    expect(provider.hasOfflineGame, isTrue);
    expect(provider.displayElements[4], 'X');
    expect(provider.filledBoxes, 1);
  });

  testWidgets('game screen waits in lobby while room is still joining', (
    tester,
  ) async {
    final socket = SocketClient.instance.socket;
    socket?.disconnect();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => RoomDataProvider(),
        child: const MaterialApp(home: GameScreen()),
      ),
    );

    expect(find.text('Waiting for another palyer to join...'), findsOneWidget);
  });
}
