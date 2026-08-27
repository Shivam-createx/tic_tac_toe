import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resouces/socket_methods.dart';
import 'package:tic_tac_toe/utils/custom_button.dart';
import 'package:tic_tac_toe/utils/custom_text.dart';
import 'package:tic_tac_toe/utils/custom_textfield.dart';
import 'package:tic_tac_toe/utils/responsive.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gameidController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListner(context);
    _socketMethods.errorOccuredListner(context);
    _socketMethods.updatePlayerDataListner(context);
  }

  @override
  void dispose() {
    _socketMethods.removeJoinRoomListeners();
    nameController.dispose();
    gameidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Join Room')),
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const CustomText(
                  text: 'Join Room',
                  textShadow: [Shadow(color: Colors.blue, blurRadius: 20)],
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextfield(
                  controller: nameController,
                  hintText: 'Enter your nickname',
                ),
                SizedBox(height: size.height * 0.01),
                CustomTextfield(
                  controller: gameidController,
                  hintText: 'Enter GameId to join',
                ),
                SizedBox(height: size.height * 0.01),
                CustomButton(
                  text: 'Join',
                  onTap: () => _socketMethods.joinRoom(
                    nameController.text,
                    gameidController.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
