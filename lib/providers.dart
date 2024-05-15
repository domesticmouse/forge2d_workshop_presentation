// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
  Highlighters({
    required this.dart,
    required this.yaml,
    required this.xml,
  });
  Highlighter dart;
  Highlighter yaml;
  Highlighter xml;
}

@riverpod
class Cursor extends _$Cursor {
  var _sectionNumber = 0;
  var _stepNumber = 0;
  var _subStepNumber = 0;

  @override
  (Section, Step, SubStep) build() => ref.watch(configurationProvider).when(
        data: (configuration) {
          final section = configuration.sections.length > _sectionNumber
              ? configuration.sections[_sectionNumber]
              : Section(name: 'Empty', steps: [], displayStepNumber: 0);
          final step = section.steps.length > _stepNumber
              ? section.steps[_stepNumber]
              : Step(name: 'Empty');
          var subStep =
              step.subSteps != null && step.subSteps!.length > _subStepNumber
                  ? step.subSteps![_subStepNumber]
                  : SubStep(name: 'Empty', extentOffset: 0);
          return (section, step, subStep);
        },
        error: (error, stackTrace) => throw error,
        loading: () => (
          Section(name: 'Empty', steps: [], displayStepNumber: 0),
          Step(name: 'Empty', displayMarkdown: 'assets/empty.txt'),
          SubStep(name: 'Empty', extentOffset: 0)
        ),
      );

  void next() {
    final configuration = ref.read(configurationProvider).asData?.value;
    if (configuration == null) return;

    var sections = configuration.sections;
    final section = sections[_sectionNumber];
    var steps = section.steps;
    final step = steps[_stepNumber];
    final subSteps = step.subSteps;

    if (subSteps != null && subSteps.length > _subStepNumber + 1) {
      _subStepNumber++;
    } else if (steps.length > _stepNumber + 1) {
      _stepNumber++;
      _subStepNumber = 0;
    } else if (sections.length > _sectionNumber + 1) {
      _sectionNumber++;
      _stepNumber = 0;
      _subStepNumber = 0;
    }

    ref.invalidateSelf();
    return;
  }

  void previous() {
    final configuration = ref.read(configurationProvider).asData?.value;
    if (configuration == null) return;

    var sections = configuration.sections;
    final section = sections[_sectionNumber];
    var steps = section.steps;
    final step = steps[_stepNumber];
    final subSteps = step.subSteps;

    if (subSteps != null && _subStepNumber > 0) {
      _subStepNumber--;
    } else if (_stepNumber > 0) {
      _stepNumber--;
      var subSteps = section.steps[_stepNumber].subSteps;
      if (subSteps != null) {
        _subStepNumber = subSteps.length - 1;
      } else {
        _subStepNumber = 0;
      }
    } else if (sections.length > _sectionNumber + 1) {
      _sectionNumber--;
      _stepNumber = sections[_sectionNumber].steps.length - 1;
      var subSteps = sections[_sectionNumber].steps[_stepNumber].subSteps;
      if (subSteps != null) {
        _subStepNumber = subSteps.length - 1;
      } else {
        _subStepNumber = 0;
      }
    }

    ref.invalidateSelf();
    return;
  }

  void setCursorPosition({
    required int sectionNumber,
    int stepNumber = 0,
    int subStepNumber = 0,
  }) {
    _sectionNumber = sectionNumber;
    _stepNumber = stepNumber;
    _subStepNumber = subStepNumber;
    ref.invalidateSelf();
  }
}

@riverpod
Future<Highlighters> highlighters(HighlightersRef ref) async {
  await Highlighter.initialize(['dart', 'yaml']);
  Highlighter.addLanguage('xml', xmlSyntax);

  var theme = await HighlighterTheme.loadDarkTheme();
  return Highlighters(
    dart: Highlighter(
      language: 'dart',
      theme: theme,
    ),
    yaml: Highlighter(
      language: 'yaml',
      theme: theme,
    ),
    xml: Highlighter(
      language: 'xml',
      theme: theme,
    ),
  );
}

// From: https://github.com/microsoft/vscode-textmate/blob/main/test-cases/themes/syntaxes/xml.json
const xmlSyntax = r'''
{
	"scopeName": "text.xml",
	"name": "XML",
	"fileTypes": [
		"atom",
		"axml",
		"bpmn",
		"config",
		"cpt",
		"csl",
		"csproj",
		"csproj.user",
		"dae",
		"dia",
		"dita",
		"ditamap",
		"dtml",
		"fodg",
		"fodp",
		"fods",
		"fodt",
		"fsproj",
		"fxml",
		"glade",
		"gpx",
		"graphml",
		"icls",
		"iml",
		"isml",
		"jmx",
		"jsp",
		"launch",
		"menu",
		"mxml",
		"nuspec",
		"opml",
		"owl",
		"pom",
		"ppj",
		"proj",
		"pt",
		"pubxml",
		"pubxml.user",
		"rdf",
		"rng",
		"rss",
		"shproj",
		"storyboard",
		"svg",
		"targets",
		"tld",
		"vbox",
		"vbox-prev",
		"vbproj",
		"vbproj.user",
		"vcproj",
		"vcproj.filters",
		"vcxproj",
		"vcxproj.filters",
		"wsdl",
		"xaml",
		"xbl",
		"xib",
		"xlf",
		"xliff",
		"xml",
		"xpdl",
		"xsd",
		"xul",
		"ui"
	],
	"patterns": [
		{
			"begin": "(<\\?)\\s*([-_a-zA-Z0-9]+)",
			"captures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "entity.name.tag.xml"
				}
			},
			"end": "(\\?>)",
			"name": "meta.tag.preprocessor.xml",
			"patterns": [
				{
					"match": " ([a-zA-Z-]+)",
					"name": "entity.other.attribute-name.xml"
				},
				{
					"include": "#doublequotedString"
				},
				{
					"include": "#singlequotedString"
				}
			]
		},
		{
			"begin": "(<!)(DOCTYPE)\\s+([:a-zA-Z_][:a-zA-Z0-9_.-]*)",
			"captures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "keyword.other.doctype.xml"
				},
				"3": {
					"name": "variable.language.documentroot.xml"
				}
			},
			"end": "\\s*(>)",
			"name": "meta.tag.sgml.doctype.xml",
			"patterns": [
				{
					"include": "#internalSubset"
				}
			]
		},
		{
			"include": "#comments"
		},
		{
			"begin": "(<)((?:([-_a-zA-Z0-9]+)(:))?([-_a-zA-Z0-9:]+))(?=(\\s[^>]*)?></\\2>)",
			"beginCaptures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "entity.name.tag.xml"
				},
				"3": {
					"name": "entity.name.tag.namespace.xml"
				},
				"4": {
					"name": "punctuation.separator.namespace.xml"
				},
				"5": {
					"name": "entity.name.tag.localname.xml"
				}
			},
			"end": "(>)(</)((?:([-_a-zA-Z0-9]+)(:))?([-_a-zA-Z0-9:]+))(>)",
			"endCaptures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "punctuation.definition.tag.xml"
				},
				"3": {
					"name": "entity.name.tag.xml"
				},
				"4": {
					"name": "entity.name.tag.namespace.xml"
				},
				"5": {
					"name": "punctuation.separator.namespace.xml"
				},
				"6": {
					"name": "entity.name.tag.localname.xml"
				},
				"7": {
					"name": "punctuation.definition.tag.xml"
				}
			},
			"name": "meta.tag.no-content.xml",
			"patterns": [
				{
					"include": "#tagStuff"
				}
			]
		},
		{
			"begin": "(</?)(?:([-\\w\\.]+)((:)))?([-\\w\\.:]+)",
			"captures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "entity.name.tag.namespace.xml"
				},
				"3": {
					"name": "entity.name.tag.xml"
				},
				"4": {
					"name": "punctuation.separator.namespace.xml"
				},
				"5": {
					"name": "entity.name.tag.localname.xml"
				}
			},
			"end": "(/?>)",
			"name": "meta.tag.xml",
			"patterns": [
				{
					"include": "#tagStuff"
				}
			]
		},
		{
			"include": "#entity"
		},
		{
			"include": "#bare-ampersand"
		},
		{
			"begin": "<%@",
			"beginCaptures": {
				"0": {
					"name": "punctuation.section.embedded.begin.xml"
				}
			},
			"end": "%>",
			"endCaptures": {
				"0": {
					"name": "punctuation.section.embedded.end.xml"
				}
			},
			"name": "source.java-props.embedded.xml",
			"patterns": [
				{
					"match": "page|include|taglib",
					"name": "keyword.other.page-props.xml"
				}
			]
		},
		{
			"begin": "<%[!=]?(?!--)",
			"beginCaptures": {
				"0": {
					"name": "punctuation.section.embedded.begin.xml"
				}
			},
			"end": "(?!--)%>",
			"endCaptures": {
				"0": {
					"name": "punctuation.section.embedded.end.xml"
				}
			},
			"name": "source.java.embedded.xml",
			"patterns": [
				{
					"include": "source.java"
				}
			]
		},
		{
			"begin": "<!\\[CDATA\\[",
			"beginCaptures": {
				"0": {
					"name": "punctuation.definition.string.begin.xml"
				}
			},
			"end": "]]>",
			"endCaptures": {
				"0": {
					"name": "punctuation.definition.string.end.xml"
				}
			},
			"name": "string.unquoted.cdata.xml"
		}
	],
	"repository": {
		"EntityDecl": {
			"begin": "(<!)(ENTITY)\\s+(%\\s+)?([:a-zA-Z_][:a-zA-Z0-9_.-]*)(\\s+(?:SYSTEM|PUBLIC)\\s+)?",
			"captures": {
				"1": {
					"name": "punctuation.definition.tag.xml"
				},
				"2": {
					"name": "keyword.other.entity.xml"
				},
				"3": {
					"name": "punctuation.definition.entity.xml"
				},
				"4": {
					"name": "variable.language.entity.xml"
				},
				"5": {
					"name": "keyword.other.entitytype.xml"
				}
			},
			"end": "(>)",
			"patterns": [
				{
					"include": "#doublequotedString"
				},
				{
					"include": "#singlequotedString"
				}
			]
		},
		"bare-ampersand": {
			"match": "&",
			"name": "invalid.illegal.bad-ampersand.xml"
		},
		"doublequotedString": {
			"begin": "\"",
			"beginCaptures": {
				"0": {
					"name": "punctuation.definition.string.begin.xml"
				}
			},
			"end": "\"",
			"endCaptures": {
				"0": {
					"name": "punctuation.definition.string.end.xml"
				}
			},
			"name": "string.quoted.double.xml",
			"patterns": [
				{
					"include": "#entity"
				},
				{
					"include": "#bare-ampersand"
				}
			]
		},
		"entity": {
			"captures": {
				"1": {
					"name": "punctuation.definition.constant.xml"
				},
				"3": {
					"name": "punctuation.definition.constant.xml"
				}
			},
			"match": "(&)([:a-zA-Z_][:a-zA-Z0-9_.-]*|#[0-9]+|#x[0-9a-fA-F]+)(;)",
			"name": "constant.character.entity.xml"
		},
		"internalSubset": {
			"begin": "(\\[)",
			"captures": {
				"1": {
					"name": "punctuation.definition.constant.xml"
				}
			},
			"end": "(\\])",
			"name": "meta.internalsubset.xml",
			"patterns": [
				{
					"include": "#EntityDecl"
				},
				{
					"include": "#parameterEntity"
				},
				{
					"include": "#comments"
				}
			]
		},
		"parameterEntity": {
			"captures": {
				"1": {
					"name": "punctuation.definition.constant.xml"
				},
				"3": {
					"name": "punctuation.definition.constant.xml"
				}
			},
			"match": "(%)([:a-zA-Z_][:a-zA-Z0-9_.-]*)(;)",
			"name": "constant.character.parameter-entity.xml"
		},
		"singlequotedString": {
			"begin": "'",
			"beginCaptures": {
				"0": {
					"name": "punctuation.definition.string.begin.xml"
				}
			},
			"end": "'",
			"endCaptures": {
				"0": {
					"name": "punctuation.definition.string.end.xml"
				}
			},
			"name": "string.quoted.single.xml",
			"patterns": [
				{
					"include": "#entity"
				},
				{
					"include": "#bare-ampersand"
				}
			]
		},
		"tagStuff": {
			"patterns": [
				{
					"captures": {
						"1": {
							"name": "entity.other.attribute-name.namespace.xml"
						},
						"2": {
							"name": "entity.other.attribute-name.xml"
						},
						"3": {
							"name": "punctuation.separator.namespace.xml"
						},
						"4": {
							"name": "entity.other.attribute-name.localname.xml"
						}
					},
					"match": "(?:^|\\s+)(?:([-\\w.]+)((:)))?([-\\w.:]+)="
				},
				{
					"include": "#doublequotedString"
				},
				{
					"include": "#singlequotedString"
				}
			]
		},
		"comments": {
			"begin": "<[!%]--",
			"captures": {
				"0": {
					"name": "punctuation.definition.comment.xml"
				}
			},
			"end": "--%?>",
			"name": "comment.block.xml"
		}
	},
	"version": "https://github.com/atom/language-xml/commit/f461d428fb87040cb8a52d87d0b95151b9d3c0cc"
}
''';
