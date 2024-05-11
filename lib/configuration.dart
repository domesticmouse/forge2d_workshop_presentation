import 'package:json_annotation/json_annotation.dart';

part 'configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Configuration {
  @JsonKey(required: true)
  final List<Section> steps;

  Configuration({required this.steps}) {
    if (steps.isEmpty) {
      throw ArgumentError.value(steps, 'steps', 'Cannot be empty.');
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

  @JsonKey(required: true)
  final List<Node> tree;

  Section({
    required this.name,
    required this.steps,
    required this.tree,
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

  Step({
    required this.name,
    this.displayCode,
    this.displayMarkdown,
    this.showGame,
    this.fileType,
    this.subSteps,
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
    if (displayCode != null && subSteps == null) {
      throw ArgumentError.value(
          subSteps, 'sub-steps', 'Cannot be null if display-code is not null.');
    }
    if (fileType != null && displayCode == null) {
      throw ArgumentError.value(
          fileType, 'file-type', 'Cannot be not null if display-code is null.');
    }
    if (subSteps != null && displayCode == null) {
      throw ArgumentError.value(
          subSteps, 'sub-steps', 'Cannot be not null if display-code is null.');
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
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;

  SubStep({
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
  }) {
    if (baseOffset < 0) {
      throw ArgumentError.value(
          baseOffset, 'baseOffset', 'Cannot be negative.');
    }
    if (extentOffset < 0) {
      throw ArgumentError.value(
          extentOffset, 'extentOffset', 'Cannot be negative.');
    }
    if (scrollPercentage < 0 || scrollPercentage > 1) {
      throw ArgumentError.value(
          scrollPercentage, 'scrollPercentage', 'Must be between 0 and 1.');
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
