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
Future<Highlighters> highlighters(HighlightersRef ref) async {
  await Highlighter.initialize(['dart', 'yaml']);
  Highlighter.addLanguage('xml', xmlSyntax);

  var theme = await HighlighterTheme.loadLightTheme();
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
