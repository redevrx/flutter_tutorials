import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:game/src/widgets/sprite_sheet_widget.dart';

class GameHome extends StatelessWidget {
  const GameHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kToolbarHeight,),
          Align(
            child: Text("Game Animation Tutorials",
            textAlign: TextAlign.center,),
          ),

          SizedBox(
            height: 12,
            width: 12,
            child: GameWidget(game: SpriteSheetWidget()),
          ),
          /// next
          
        ],
      ),
    );
  }
}

