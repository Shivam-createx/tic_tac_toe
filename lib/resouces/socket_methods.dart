import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resouces/game_method.dart';
import 'package:tic_tac_toe/resouces/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/utils/utils.dart';
import 'package:tic_tac_toe/widget/show_game_dialog.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void _navigateToGameScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = Navigator.of(context, rootNavigator: true);
      if (navigator.mounted) {
        navigator.pushNamed(GameScreen.roomName);
      }
    });
  }

  // Emitters
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickname});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  //Listners
  void createRoomSuccessListner(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(room);
      _navigateToGameScreen(context);
    });
  }

  void joinRoomSuccessListner(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (roomData) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(roomData);
      _navigateToGameScreen(context);
    });
  }

  void errorOccuredListner(BuildContext context) {
    _socketClient.on('errorOccured', (message) {
      snackbarMessage(context, message);
    });
  }

  void updatePlayerDataListner(BuildContext context) {
    _socketClient.on('updatePlayer', (playerData) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListner(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(data);
    });
  }

  void tappedListner(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider dataProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      dataProvider.updateDisplayElement(data['index'], data['choice']);
      dataProvider.updateRoomData(data['room']);
      GameMethod().checkWinner(context, _socketClient);
    });
  }

  void increasePointListner(BuildContext context) {
    _socketClient.on('increasePoint', (playerData) {
      RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      if (playerData['socketID'] == roomDataProvider.player1.socketId) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListner(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (value) => false);
    });
  }
}
