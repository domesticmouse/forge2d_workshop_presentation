import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DisplayMarkdown extends StatefulWidget {
  const DisplayMarkdown({
    super.key,
    required this.assetPath,
  });

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

  final controller = ScrollController();
  late Future<String> content;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Markdown(
            data: snapshot.data ?? '',
            controller: controller,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(textScaler: TextScaler.linear(2.0)),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
