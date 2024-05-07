import 'package:checked_yaml/checked_yaml.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'configuration.dart';

part 'providers.g.dart';

@riverpod
Future<Configuration> configuration(ConfigurationRef ref) async {
  final yaml = await rootBundle.loadString('assets/steps.yaml');
  return checkedYamlDecode(yaml, (m) => Configuration.fromJson(m!));
}

class Highlighters {
  Highlighters(this.dartHighlighter, this.yamlHighlighter);
  Highlighter dartHighlighter;
  Highlighter yamlHighlighter;
}

@riverpod
Future<Highlighters> highlighters(HighlightersRef ref) async {
  await Highlighter.initialize(['dart', 'yaml']);
  var theme = await HighlighterTheme.loadLightTheme();
  final dartHighlighter = Highlighter(
    language: 'dart',
    theme: theme,
  );
  final yamlHighlighter = Highlighter(
    language: 'yaml',
    theme: theme,
  );
  return Highlighters(dartHighlighter, yamlHighlighter);
}
