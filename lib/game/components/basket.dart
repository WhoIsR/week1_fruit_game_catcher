import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent with HasGameRef, CollisionCallbacks {
  Basket() : super(size: Vector2(80, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    add(RectangleHitbox());
  }
}
