import 'package:checked_yaml/checked_yaml.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge2d_workshop_presentation/configuration.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Test loading the configuration', () async {
    final stepsYaml = await rootBundle.loadString('assets/steps.yaml');
    final config = checkedYamlDecode(
      stepsYaml,
      (m) => Configuration.fromJson(m!),
    );
    expect(config, isNotNull);
  });
}
