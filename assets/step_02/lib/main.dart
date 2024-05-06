import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget.controlled(
      gameFactory: FlameGame.new,
    ),
  );
}
