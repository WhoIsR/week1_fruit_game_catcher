import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/basket.dart';
import 'components/fruit.dart';
import '../managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  final Random random = Random();

  // Timer buat spawn buah
  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  // Skor
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  int _score = 0;

  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value;
  }

  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // Warna Langit

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Set Kamera biar pas di tengah
    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    basket = Basket();
    await add(basket);

    //Play Music
    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    //LOGIKA SPAWN BUAH
    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  // Fungsi buat munculin buah di posisi random
  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    // Muncul sedikit di atas layar (-50) biar jatuhnya alus
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  // Fungsi biar keranjang bisa digeser jari
  @override
  void onPanUpdate(DragUpdateInfo info) {
    // Geser posisi X basket sesuai gerakan jari
    basket.position.x += info.delta.global.x;

    // Batasi biar gak keluar layar (Clamp)
    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  // Fungsi nambah skor (dipanggil dari fruit.dart nanti)
  void incrementScore() {
    score++;
    AudioManager().playSfx('collect.mp3');
  }

  @override
  void onRemove() {
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }
}
