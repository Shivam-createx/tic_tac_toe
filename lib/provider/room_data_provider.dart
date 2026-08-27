import 'package:flutter/material.dart';
import 'package:tic_tac_toe/model/player.dart';

class RoomDataProvider with ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  String symbol = 'X';
  bool _hasOfflineGame = false;
  // ignore: unused_field
  int _filledBoxes = 0;
  Player _player1 = Player(
    nickname: 'Player 1',
    socketId: '',
    points: 0,
    playerType: 'X',
  );

  Player _player2 = Player(
    nickname: 'Player 2',
    socketId: '',
    points: 0,
    playerType: 'O',
  );

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;
  bool get hasOfflineGame => _hasOfflineGame;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;

    final players = _roomData['players'];
    if (players is List && players.isNotEmpty) {
      _player1 = Player.fromMap(players.first as Map<String, dynamic>);
      if (players.length > 1) {
        _player2 = Player.fromMap(players[1] as Map<String, dynamic>);
      }
    }
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void startNewOfflineGame(String player1name, String player2name) {
    _displayElements = ['', '', '', '', '', '', '', '', ''];
    _filledBoxes = 0;
    symbol = 'X';
    _player1 = _player1.copyWith(nickname: player1name, points: 0);
    _player2 = _player2.copyWith(nickname: player2name, points: 0);
    _hasOfflineGame = true;
    notifyListeners();
  }

  void increasePlayerPoints(double player1Point, double player2Point) {
    _player1 = _player1.copyWith(points: player1Point);
    _player2 = _player2.copyWith(points: player2Point);
    notifyListeners();
  }

  void updateData(int index) {
    if (symbol == 'X') {
      _displayElements[index] = 'X';
      symbol = 'O';
    } else {
      _displayElements[index] = 'O';
      symbol = 'X';
    }
    _filledBoxes += 1;
    if (_filledBoxes >= 9) {}
    notifyListeners();
  }

  void updatePoints(String playerType) {
    if (playerType == 'X') {
      _player1 = _player1.copyWith(points: player1.points + 1);
    } else {
      _player2 = _player2.copyWith(points: player2.points + 1);
    }
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void clearFilledBoxes() {
    _filledBoxes = 0;
  }
}
