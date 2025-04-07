// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DisplayMarkdown extends StatefulWidget {
  const DisplayMarkdown({super.key, required this.assetPath});

  final String assetPath;

  @override
  State<DisplayMarkdown> createState() => _DisplayMarkdownState();
}

class _DisplayMarkdownState extends State<DisplayMarkdown> {
  @override
  void initState() {
    super.initState();
    content = rootBundle.loadString(widget.assetPath);
  }

  @override
  void didUpdateWidget(covariant DisplayMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    content = rootBundle.loadString(widget.assetPath);
  }

  final controller = ScrollController();
  late Future<String> content;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 1000,
              height: 800,
              child: Markdown(
                data: snapshot.data ?? '',
                controller: controller,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  Theme.of(context),
                ).copyWith(textScaler: TextScaler.linear(1.75)),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
