// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) => $checkedCreate(
      'Configuration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['sections'],
          requiredKeys: const ['sections'],
        );
        final val = Configuration(
          sections: $checkedConvert(
              'sections',
              (v) => (v as List<dynamic>)
                  .map((e) => Section.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'sections': instance.sections,
    };

Section _$SectionFromJson(Map json) => $checkedCreate(
      'Section',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['name', 'step-number', 'steps'],
          requiredKeys: const ['name', 'step-number', 'steps'],
        );
        final val = Section(
          name: $checkedConvert('name', (v) => v as String),
          steps: $checkedConvert(
              'steps',
              (v) => (v as List<dynamic>)
                  .map((e) => Step.fromJson(e as Map))
                  .toList()),
          displayStepNumber:
              $checkedConvert('step-number', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'displayStepNumber': 'step-number'},
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'name': instance.name,
      'step-number': instance.displayStepNumber,
      'steps': instance.steps,
    };

Step _$StepFromJson(Map json) => $checkedCreate(
      'Step',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'name',
            'display-code',
            'display-markdown',
            'show-game',
            'file-type',
            'sub-steps',
            'tree'
          ],
          requiredKeys: const ['name'],
        );
        final val = Step(
          name: $checkedConvert('name', (v) => v as String),
          displayCode: $checkedConvert('display-code', (v) => v as String?),
          displayMarkdown:
              $checkedConvert('display-markdown', (v) => v as String?),
          showGame: $checkedConvert('show-game', (v) => v as String?),
          fileType: $checkedConvert('file-type', (v) => v as String?),
          subSteps: $checkedConvert(
              'sub-steps',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => SubStep.fromJson(e as Map))
                  .toList()),
          tree: $checkedConvert(
              'tree',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayCode': 'display-code',
        'displayMarkdown': 'display-markdown',
        'showGame': 'show-game',
        'fileType': 'file-type',
        'subSteps': 'sub-steps'
      },
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'name': instance.name,
      'display-code': instance.displayCode,
      'display-markdown': instance.displayMarkdown,
      'show-game': instance.showGame,
      'file-type': instance.fileType,
      'sub-steps': instance.subSteps,
      'tree': instance.tree,
    };

SubStep _$SubStepFromJson(Map json) => $checkedCreate(
      'SubStep',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'name',
            'base-offset',
            'extent-offset',
            'scroll-percentage',
            'scroll-seconds'
          ],
        );
        final val = SubStep(
          name: $checkedConvert('name', (v) => v as String),
          baseOffset: $checkedConvert('base-offset', (v) => (v as num).toInt()),
          extentOffset:
              $checkedConvert('extent-offset', (v) => (v as num?)?.toInt()),
          scrollPercentage: $checkedConvert(
              'scroll-percentage', (v) => (v as num?)?.toDouble()),
          scrollSeconds:
              $checkedConvert('scroll-seconds', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'baseOffset': 'base-offset',
        'extentOffset': 'extent-offset',
        'scrollPercentage': 'scroll-percentage',
        'scrollSeconds': 'scroll-seconds'
      },
    );

Map<String, dynamic> _$SubStepToJson(SubStep instance) => <String, dynamic>{
      'name': instance.name,
      'base-offset': instance.baseOffset,
      'extent-offset': instance.extentOffset,
      'scroll-percentage': instance.scrollPercentage,
      'scroll-seconds': instance.scrollSeconds,
    };

Node _$NodeFromJson(Map json) => $checkedCreate(
      'Node',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'directory',
            'file',
            'file-type',
            'children',
            'contents'
          ],
        );
        final val = Node(
          directory: $checkedConvert('directory', (v) => v as String?),
          file: $checkedConvert('file', (v) => v as String?),
          fileType: $checkedConvert('file-type', (v) => v as String?),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map))
                  .toList()),
          contents: $checkedConvert('contents', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'fileType': 'file-type'},
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'directory': instance.directory,
      'file': instance.file,
      'file-type': instance.fileType,
      'children': instance.children,
      'contents': instance.contents,
    };
