import 'dart:async';
import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';

class SpriteSheetWidget extends FlameGame with TapDetector {
  final double factory = 3.0;
  late SpriteAnimationComponent spriteAnimation;

  @override
  void onTapDown(TapDownInfo info) {
    ///
  }

  @override
  FutureOr<void> load() async {
    final loader = Images(prefix: 'assets/game/');
    final image = await loader.load('cat_sprite.png'); // โหลดภาพ
    final size = Vector2(50, 50); // ขนาดที่ต้องการให้แสดง

    final sheet = SpriteSheet(image: image, srcSize: size);
    final animation = sheet.createAnimation(row: 0, stepTime: .1, to: 60);

    spriteAnimation = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(2, 2), // ใช้ scale ที่คำนวณ
      position: Vector2(-100, 50), // กำหนดตำแหน่งที่คำนวณ
      size: size, // ขนาดที่ต้องการแสดง
    );

    // เพิ่ม SpriteAnimationComponent เข้าไปในเกม
    add(spriteAnimation);
  }
}
