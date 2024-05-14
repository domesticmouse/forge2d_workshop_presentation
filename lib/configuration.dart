import 'package:json_annotation/json_annotation.dart';

part 'configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Configuration {
  @JsonKey(required: true)
  final List<Section> sections;

  Configuration({required this.sections}) {
    if (sections.isEmpty) {
      throw ArgumentError.value(sections, 'steps', 'Cannot be empty.');
    }
  }

  factory Configuration.fromJson(Map json) => _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @override
  String toString() => 'Configuration: ${toJson()}';
}

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Section {
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true, name: 'step-number')
  final int displayStepNumber;

  @JsonKey(required: true)
  final List<Step> steps;

  Section({
    required this.name,
    required this.steps,
    required this.displayStepNumber,
  }) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Cannot be empty.');
    }
  }

  factory Section.fromJson(Map json) => _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  @override
  String toString() => 'Step: ${toJson()}';
}

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Step {
  @JsonKey(required: true)
  final String name;

  @JsonKey(name: 'display-code')
  final String? displayCode;

  @JsonKey(name: 'display-markdown')
  final String? displayMarkdown;

  @JsonKey(name: 'show-game')
  final String? showGame;

  @JsonKey(name: 'file-type')
  final String? fileType;

  @JsonKey(name: 'sub-steps')
  final List<SubStep>? subSteps;

  final List<Node>? tree;

  Step({
    required this.name,
    this.displayCode,
    this.displayMarkdown,
    this.showGame,
    this.fileType,
    this.subSteps,
    this.tree,
  }) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Cannot be empty.');
    }
    if (displayCode != null && displayMarkdown != null) {
      throw ArgumentError.value(displayCode, 'display-code',
          'Cannot have both display-code and display-markdown.');
    }
    if (displayCode != null && showGame != null) {
      throw ArgumentError.value(displayCode, 'display-code',
          'Cannot have both display-code and show-game.');
    }
    if (displayMarkdown != null && showGame != null) {
      throw ArgumentError.value(displayMarkdown, 'display-markdown',
          'Cannot have both display-markdown and show-game.');
    }
    if (displayCode != null && fileType == null) {
      throw ArgumentError.value(
          fileType, 'file-type', 'Cannot be null if display-code is not null.');
    }
    if (displayCode != null && subSteps == null && fileType != 'png') {
      throw ArgumentError.value(
          subSteps, 'sub-steps', 'Cannot be null if display-code is not null.');
    }
    if (displayCode != null && tree == null) {
      throw ArgumentError.value(
          tree, 'tree', 'Cannot be null if display-code is not null.');
    }
    if (fileType != null && displayCode == null) {
      throw ArgumentError.value(
          fileType, 'file-type', 'Cannot be not null if display-code is null.');
    }
    if (subSteps != null && displayCode == null) {
      throw ArgumentError.value(
          subSteps, 'sub-steps', 'Cannot be not null if display-code is null.');
    }
    if (tree != null && displayCode == null) {
      throw ArgumentError.value(
          tree, 'tree', 'Cannot be not null if display-code is null.');
    }
    if (showGame == null && displayCode == null && displayMarkdown == null) {
      throw ArgumentError.value(showGame, 'show-game',
          'Cannot be null if display-code and display-markdown are null.');
    }
  }

  factory Step.fromJson(Map json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);

  @override
  String toString() => 'Step: ${toJson()}';
}

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class SubStep {
  final String name;

  @JsonKey(name: 'base-offset')
  final int? baseOffset;

  @JsonKey(name: 'extent-offset')
  final int extentOffset;

  @JsonKey(name: 'scroll-percentage')
  final double? scrollPercentage;

  @JsonKey(name: 'scroll-seconds')
  final int? scrollSeconds;

  SubStep({
    required this.name,
    this.baseOffset,
    required this.extentOffset,
    this.scrollPercentage,
    this.scrollSeconds,
  }) {
    if (extentOffset < 0) {
      throw ArgumentError.value(
          extentOffset, 'extent-offset', 'Cannot be negative.');
    }
    if (baseOffset != null && baseOffset! < 0) {
      throw ArgumentError.value(
          baseOffset, 'base-offset', 'Cannot be negative.');
    }
    if (scrollPercentage != null &&
        (scrollPercentage! < 0 || scrollPercentage! > 100)) {
      throw ArgumentError.value(
          scrollPercentage, 'scroll-percentage', 'Must be between 0 and 100.');
    }
  }

  factory SubStep.fromJson(Map json) => _$SubStepFromJson(json);

  Map<String, dynamic> toJson() => _$SubStepToJson(this);

  @override
  String toString() => 'SubStep: ${toJson()}';
}

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Node {
  final String? directory;
  final String? file;
  @JsonKey(name: 'file-type')
  final String? fileType;
  final List<Node>? children;
  final String? contents;

  String get title => directory ?? file ?? '';

  Node({
    this.directory,
    this.file,
    this.fileType,
    this.children,
    this.contents,
  }) {
    if ((directory == null || directory!.isEmpty) &&
        (file == null || file!.isEmpty)) {
      throw ArgumentError.value(
          directory, 'directory', 'Cannot be empty if file is empty.');
    }

    if (file != null &&
        file!.isNotEmpty &&
        (fileType == null || fileType!.isEmpty)) {
      throw ArgumentError.value(
          fileType, 'fileType', 'Cannot be empty if file is not empty.');
    }

    if ((directory == null || directory!.isEmpty) &&
        children != null &&
        children!.isNotEmpty) {
      throw ArgumentError.value(
          children, 'children', 'Cannot have children if directory is empty.');
    }
  }

  factory Node.fromJson(Map json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  @override
  String toString() => 'Node: ${toJson()}';
}
