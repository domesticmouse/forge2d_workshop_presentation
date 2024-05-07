import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../configuration.dart';
import '../providers.dart';

class DisplayCode extends ConsumerStatefulWidget {
  const DisplayCode({
    super.key,
    required this.assetPath,
    required this.fileType,
    required this.tree,
  });

  final String assetPath;
  final String fileType;
  final List<Node> tree;

  @override
  ConsumerState<DisplayCode> createState() => _DisplayCodeState();
}

class _DisplayCodeState extends ConsumerState<DisplayCode> {
  @override
  void initState() {
    super.initState();

    content = rootBundle.loadString(widget.assetPath);
  }

  late Future<String> content;

  @override
  Widget build(BuildContext context) {
    final highlightersAsync = ref.watch(highlightersProvider);
    return highlightersAsync.when(
      data: (highlighters) => FutureBuilder<String>(
        future: content,
        builder: (context, snapshot) =>
            switch ((snapshot.hasData, snapshot.hasError)) {
          (true, _) => _DisplayCodeHelper(
              assetPath: widget.assetPath,
              content: snapshot.data ?? '',
              fileType: widget.fileType,
              tree: widget.tree,
              highlighters: highlighters,
            ),
          (_, true) => Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          _ => Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}

class _DisplayCodeHelper extends StatelessWidget {
  const _DisplayCodeHelper({
    required this.assetPath,
    required this.content,
    required this.fileType,
    required this.tree,
    required this.highlighters,
  });

  final String assetPath;
  final String content;
  final String fileType;
  final List<Node> tree;
  final Highlighters highlighters;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
