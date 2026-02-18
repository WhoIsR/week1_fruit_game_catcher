import 'package:flutter/material.dart';
import 'package:flutter_fruit_game_catcher/managers/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Fruit Catcher Game', home: const GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ValueNotifier<int> counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (context, score, child) {
                  return Text(
                    'Score: $score',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
