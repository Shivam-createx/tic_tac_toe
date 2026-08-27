import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/utils/custom_textfield.dart';
import 'package:tic_tac_toe/utils/responsive.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController gameidController;

  @override
  void initState() {
    super.initState();
    gameidController = TextEditingController();
    _syncRoomId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncRoomId();
  }

  void _syncRoomId() {
    final roomId = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    ).roomData['_id'];
    final nextValue = roomId?.toString() ?? '';
    if (gameidController.text != nextValue) {
      gameidController.text = nextValue;
      gameidController.selection = TextSelection.fromPosition(
        TextPosition(offset: nextValue.length),
      );
    }
  }

  @override
  void dispose() {
    gameidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final padding = isSmallScreen ? 16.0 : 32.0;
    final fontSize = isSmallScreen ? 14.0 : 16.0;

    return Scaffold(
      body: Responsive(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Waiting for another player to join...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: gameidController,
                    hintText: '',
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
