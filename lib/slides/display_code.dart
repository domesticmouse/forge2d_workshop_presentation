import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_text_layout/super_text_layout.dart';

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
        child: Text('Error: $error\n$stack'),
      ),
    );
  }
}

class _DisplayCodeHelper extends StatefulWidget {
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
  State<_DisplayCodeHelper> createState() => _DisplayCodeHelperState();
}

class _DisplayCodeHelperState extends State<_DisplayCodeHelper> {
  late final TreeController<Node> treeController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    treeController = TreeController<Node>(
      roots: widget.tree,
      childrenProvider: (node) => node.children ?? [],
      defaultExpansionState: true,
    );

    scrollController = ScrollController()
      ..addListener(() {
        debugPrint('scrollController.offset: ${scrollController.offset}');
      });
  }

  @override
  Widget build(BuildContext context) {
    const textSelection = TextSelection(
      baseOffset: 0,
      extentOffset: 0,
      affinity: TextAffinity.downstream,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 300,
          child: AnimatedTreeView(
            padding: const EdgeInsets.all(12),
            treeController: treeController,
            nodeBuilder: (context, entry) => TreeIndentation(
              guide: IndentGuide.connectingLines(
                indent: 16,
                color: Colors.grey,
                thickness: 2.0,
                origin: 0.6,
                padding: EdgeInsets.symmetric(horizontal: 8),
                // roundCorners: true,
              ),
              entry: entry,
              child: Text(
                entry.node.title,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: entry.node.title == 'game.dart'
                        ? FontWeight.w500
                        : FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
        VerticalDivider(
          thickness: 1,
          color: Colors.black.withOpacity(0.3),
        ),
        SizedBox(width: 12), // Add some space between the tree and the code
        Expanded(
          child: NotificationListener<ScrollMetricsNotification>(
            onNotification: (notification) {
              debugPrint('ScrollMetricsNotification.metrics.minScrollExtent: '
                  '${notification.metrics.minScrollExtent}');
              debugPrint('ScrollMetricsNotification.metrics.maxScrollExtent: '
                  '${notification.metrics.maxScrollExtent}');
              return false;
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: SuperText(
                richText: TextSpan(
                  style: GoogleFonts.robotoMono(
                    textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  children: [
                    switch (widget.fileType) {
                      'dart' =>
                        widget.highlighters.dart.highlight(widget.content),
                      'yaml' =>
                        widget.highlighters.yaml.highlight(widget.content),
                      'xml' =>
                        widget.highlighters.xml.highlight(widget.content),
                      _ => TextSpan(
                          text: widget.content,
                          style: const TextStyle(color: Colors.black),
                        ),
                    },
                  ],
                ),
                layerAboveBuilder: (context, textLayout) {
                  return Stack(
                    children: [
                      TextLayoutCaret(
                        textLayout: textLayout,
                        style: const CaretStyle(
                          color: Colors.black,
                          width: 2,
                        ),
                        position:
                            TextPosition(offset: textSelection.extentOffset),
                      ),
                    ],
                  );
                },
                layerBeneathBuilder: (context, textLayout) {
                  return Stack(
                    children: [
                      TextLayoutSelectionHighlight(
                        textLayout: textLayout,
                        style: SelectionHighlightStyle(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                        selection: textSelection,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
