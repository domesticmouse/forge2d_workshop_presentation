// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

import 'background.dart';

class MyPhysicsGame extends Forge2DGame {
  MyPhysicsGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  late final XmlSpriteSheet aliens;
  late final XmlSpriteSheet elements;
  late final XmlSpriteSheet tiles;

  @override
  FutureOr<void> onLoad() async {
    final [backgroundImage, aliensImage, elementsImage, tilesImage] =
        await [
          images.load('colored_grass.png'),
          images.load('spritesheet_aliens.png'),
          images.load('spritesheet_elements.png'),
          images.load('spritesheet_tiles.png'),
        ].wait;
    aliens = XmlSpriteSheet(
      aliensImage,
      await rootBundle.loadString('assets/spritesheet_aliens.xml'),
    );
    elements = XmlSpriteSheet(
      elementsImage,
      await rootBundle.loadString('assets/spritesheet_elements.xml'),
    );
    tiles = XmlSpriteSheet(
      tilesImage,
      await rootBundle.loadString('assets/spritesheet_tiles.xml'),
    );

    await world.add(Background(sprite: Sprite(backgroundImage)));

    return super.onLoad();
  }
}

class XmlSpriteSheet {
  XmlSpriteSheet(this.image, String xml) {
    final document = XmlDocument.parse(xml);
    for (final node in document.xpath('//TextureAtlas/SubTexture')) {
      final name = node.getAttribute('name')!;
      final x = double.parse(node.getAttribute('x')!);
      final y = double.parse(node.getAttribute('y')!);
      final width = double.parse(node.getAttribute('width')!);
      final height = double.parse(node.getAttribute('height')!);
      _rects[name] = Rect.fromLTWH(x, y, width, height);
    }
  }

  final ui.Image image;
  final _rects = <String, Rect>{};

  Sprite getSprite(String name) {
    final rect = _rects[name];
    if (rect == null) {
      throw ArgumentError('Sprite $name not found');
    }
    return Sprite(
      image,
      srcPosition: rect.topLeft.toVector2(),
      srcSize: rect.size.toVector2(),
    );
  }
}
