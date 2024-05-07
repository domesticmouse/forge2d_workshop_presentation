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
        child: Text('Error: $error'),
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

    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 350,
          child: AnimatedTreeView(
            padding: const EdgeInsets.all(12),
            treeController: treeController,
            nodeBuilder: (context, entry) => TreeIndentation(
              guide: IndentGuide.connectingLines(
                indent: 32,
                color: Colors.grey,
                thickness: 2.0,
                origin: 0.5,
                padding: EdgeInsets.symmetric(horizontal: 8),
                // roundCorners: true,
              ),
              entry: entry,
              child: Text(
                entry.node.title,
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: entry.node.title == 'game.dart'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
        VerticalDivider(
          thickness: 1,
          color: Colors.black.withOpacity(0.5),
          indent: 12,
          endIndent: 12,
        ),
        SizedBox(width: 12), // Add some space between the tree and the code
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SuperText(
              richText: TextSpan(
                style: GoogleFonts.robotoMono(
                  textStyle: const TextStyle(fontSize: 34),
                ),
                children: [
                  switch (widget.fileType) {
                    'dart' => widget.highlighters.dartHighlighter
                        .highlight(widget.content),
                    'yaml' => widget.highlighters.yamlHighlighter
                        .highlight(widget.content),
                    _ => TextSpan(text: widget.content),
                  },
                ],
              ),
              layerAboveBuilder: (context, textLayout) {
                return Stack(
                  children: [
                    TextLayoutCaret(
                      textLayout: textLayout,
                      style: const CaretStyle(
                        color: Colors.red,
                        width: 2,
                      ),
                      position: const TextPosition(offset: 0),
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
                      selection: const TextSelection(
                        baseOffset: 0,
                        extentOffset: 0,
                        affinity: TextAffinity.downstream,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
