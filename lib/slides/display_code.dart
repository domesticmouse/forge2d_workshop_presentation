import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:super_text_layout/super_text_layout.dart';

import '../configuration.dart';
import '../providers.dart';

class DisplayCode extends ConsumerStatefulWidget {
  const DisplayCode({
    super.key,
    required this.assetPath,
    required this.fileType,
    required this.tree,
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
  });

  final String assetPath;
  final String fileType;
  final List<Node> tree;
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;

  @override
  ConsumerState<DisplayCode> createState() => _DisplayCodeState();
}

class _DisplayCodeState extends ConsumerState<DisplayCode> {
  @override
  void initState() {
    super.initState();
    content = rootBundle.loadString(widget.assetPath);
  }

  @override
  void didUpdateWidget(covariant DisplayCode oldWidget) {
    super.didUpdateWidget(oldWidget);
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
              baseOffset: widget.baseOffset,
              extentOffset: widget.extentOffset,
              scrollPercentage: widget.scrollPercentage,
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
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
  });

  final String assetPath;
  final String content;
  final String fileType;
  final List<Node> tree;
  final Highlighters highlighters;
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;

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
  void didUpdateWidget(covariant _DisplayCodeHelper oldWidget) {
    super.didUpdateWidget(oldWidget);
    treeController.roots = widget.tree;
    scrollController.animateTo(
      scrollController.position.maxScrollExtent * widget.scrollPercentage,
      duration: Durations.long4,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final textSelection = TextSelection(
      baseOffset: widget.baseOffset,
      extentOffset: widget.extentOffset,
      affinity: TextAffinity.downstream,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.1098633 * size.width + 133.0078,
          child: AnimatedTreeView(
            padding: const EdgeInsets.all(12),
            treeController: treeController,
            nodeBuilder: (context, entry) => TreeIndentation(
              guide: IndentGuide.connectingLines(
                indent: 0.01052632 * size.width + 5.052632,
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
                    fontSize: 0.01972973 * size.height + 4.945946,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight:
                        entry.node.title == path.split(widget.assetPath).last
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
                    textStyle: TextStyle(
                      fontSize: 0.02567568 * size.height - 1.864865,
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
