import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/screens/main_screen.dart';
import 'package:tic_tac_toe/screens/off_game_screen.dart';
import 'package:tic_tac_toe/screens/pre_off_game_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Tic tac toe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgcolor,
          appBarTheme: AppBarThemeData(backgroundColor: bgcolor, elevation: 0),
        ),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.roomName: (context) => const GameScreen(),
          PreOffGameScreen.routeName: (context) => const PreOffGameScreen(),
          OffGameScreen.routeName: (context) => const OffGameScreen(),
        },
        initialRoute: MainScreen.routeName,
      ),
    );
  }
}
