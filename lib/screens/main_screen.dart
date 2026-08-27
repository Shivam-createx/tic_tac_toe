import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/screens/pre_off_game_screen.dart';
import 'package:tic_tac_toe/utils/custom_button.dart';
import 'package:tic_tac_toe/utils/responsive.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main-screen';
  const MainScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void preOffgameScreen(BuildContext context) {
    Navigator.pushNamed(context, PreOffGameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            CustomButton(text: 'Create Room', onTap: () => createRoom(context)),
            CustomButton(text: 'Join Room', onTap: () => joinRoom(context)),
            TextButton(
              onPressed: () => preOffgameScreen(context),
              child: Text(
                'Play Offline!',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
