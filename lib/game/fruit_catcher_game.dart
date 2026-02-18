import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    AudioManager().playBackgroundMusic();
  }

  Color backgroundColor() => const Color(0xFF87CEEB);

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
}
