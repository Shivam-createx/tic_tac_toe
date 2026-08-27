import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/off_game_screen.dart';
import 'package:tic_tac_toe/utils/custom_textfield.dart';
import 'package:tic_tac_toe/utils/responsive.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class PreOffGameScreen extends StatefulWidget {
  static const String routeName = '/preOffGameScreen';
  const PreOffGameScreen({super.key});

  @override
  State<PreOffGameScreen> createState() => _PreOffGameScreenState();
}

class _PreOffGameScreenState extends State<PreOffGameScreen> {
  final TextEditingController player1NameController = TextEditingController();
  final TextEditingController player2NameController = TextEditingController();

  @override
  void dispose() {
    player1NameController.dispose();
    player2NameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    player1NameController.text = 'Player 1';
    player2NameController.text = 'Player 2';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final roomDataProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      if (roomDataProvider.hasOfflineGame) {
        _showSavedGameChoice(roomDataProvider);
      }
    });
  }

  Future<void> _showSavedGameChoice(RoomDataProvider roomDataProvider) async {
    final shouldContinue = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Continue previous game?'),
          content: Text(
            '${roomDataProvider.player1.nickname} vs '
            '${roomDataProvider.player2.nickname}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Start New'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (shouldContinue == true) {
      Navigator.pushReplacementNamed(context, OffGameScreen.routeName);
    }
  }

  void nextScreen(BuildContext context, RoomDataProvider roomDataProvider) {
    if (player1NameController.text.length >= 30 ||
        player2NameController.text.length >= 30) {
      return snackbarMessage(
        context,
        'Name length should be less than 30 characters!',
      );
    }
    if (player1NameController.text.trim().isEmpty ||
        player2NameController.text.trim().isEmpty) {
      return snackbarMessage(context, 'Names cannot be empty!');
    }
    roomDataProvider.startNewOfflineGame(
      player1NameController.text.trim(),
      player2NameController.text.trim(),
    );
    Navigator.pushReplacementNamed(context, OffGameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Game')),
      body: Center(
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              CustomTextfield(
                controller: player1NameController,
                hintText: 'Enter first Player Name',
              ),
              CustomTextfield(
                controller: player2NameController,
                hintText: "Enter 2nd Palyer name",
              ),
              ElevatedButton(
                onPressed: () => nextScreen(context, roomDataProvider),
                child: Text(
                  'Let\'s Play!',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
