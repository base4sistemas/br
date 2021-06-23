import 'package:br/br.dart';
import 'package:test/test.dart';

const List<String> knownAbbrs = [
  'AC',
  'AL',
  'AM',
  'AP',
  'BA',
  'CE',
  'DF',
  'ES',
  'GO',
  'MA',
  'MG',
  'MS',
  'MT',
  'PA',
  'PB',
  'PE',
  'PI',
  'PR',
  'RJ',
  'RN',
  'RO',
  'RR',
  'RS',
  'SC',
  'SE',
  'SP',
  'TO',
];

void main() {
  group('Test simple State validation', () {
    test('All valid State abbreviations', () {
      for (String abbr in knownAbbrs) {
        expect(isState(abbr), isTrue);
      }
    });
    test(
        'All State abbreviations should map to the same State abbreviation in State\'s instance abbr attribute',
        () {
      for (String abbr in knownAbbrs) {
        expect(getState(abbr).abbr, equals(abbr));
      }
    });
  });

  group('Test known State and StateRegion instances', () {
    test('Test for State of São Paulo', () {
      State state = getState('SP');
      expect(state.abbr, equals('SP'));
      expect(state.name, equals('São Paulo'));
      expect(state.ibge, equals(35));
      expect(state.label, equals('São Paulo (SP)'));
      expect(state.region.abbr, equals('SE'));
      expect(state.region.name, equals('Sudeste'));
    });
    test('Test for south east region', () {
      expect(southEast.abbr, equals('SE'));
      expect(southEast.name, equals('Sudeste'));
      expect(southEast.label, equals('Sudeste (SE)'));
    });
  });
}
