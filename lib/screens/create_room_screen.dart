import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resouces/socket_methods.dart';
import 'package:tic_tac_toe/utils/custom_button.dart';
import 'package:tic_tac_toe/utils/custom_text.dart';
import 'package:tic_tac_toe/utils/custom_textfield.dart';
import 'package:tic_tac_toe/utils/responsive.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  final SocketMethods _socketMethod = SocketMethods();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _socketMethod.createRoomSuccessListner(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const CustomText(
                  text: 'Create Room',
                  textShadow: [Shadow(color: Colors.blue, blurRadius: 20)],
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextfield(
                  controller: nameController,
                  hintText: 'Enter your name',
                ),
                SizedBox(height: size.height * 0.01),
                CustomButton(
                  text: 'Create',
                  onTap: () => _socketMethod.createRoom(nameController.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
