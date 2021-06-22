import 'package:br/br.dart';
import 'package:test/test.dart';

void main() {
  // All CPF numbers here are fictional.
  group('Test valid CPF numbers both masked and unmasked', () {
    test('Valid CPF number with lowest code value', () {
      expect(isCpf('000.000.001-91'), isTrue);
      expect(isCpf('00000000191'), isTrue);
    });
    test('Valid CPF number with highest code value', () {
      expect(isCpf('999.999.998-08'), isTrue);
      expect(isCpf('99999999808'), isTrue);
    });
    test('Valid CPF number with sequential code value', () {
      expect(isCpf('123.456.789-09'), isTrue);
      expect(isCpf('12345678909'), isTrue);
    });
  });

  group('Test invalid CPF numbers', () {
    test('A CPF cannot be made up of same digit', () {
      expect(isCpf('000.000.000-00'), isFalse);
      expect(isCpf('111.111.111-11'), isFalse);
      expect(isCpf('222.222.222-22'), isFalse);
      expect(isCpf('333.333.333-33'), isFalse);
      expect(isCpf('444.444.444-44'), isFalse);
      expect(isCpf('555.555.555-55'), isFalse);
      expect(isCpf('666.666.666-66'), isFalse);
      expect(isCpf('777.777.777-77'), isFalse);
      expect(isCpf('888.888.888-88'), isFalse);
      expect(isCpf('999.999.999-99'), isFalse);
    });
    test('A slightly different version of valid CPF', () {
      // changed last checksum digit
      expect(isCpf('123.456.789-08'), isFalse);
    });
    test('Improperly masked CPF', () {
      // although the number is valid, it's improperly masked
      expect(isCpf('123.456.789.09'), isFalse);
      expect(isCpf('.12345678909'), isFalse);
    });
  });

  group('Test Cpf class', () {
    test('Creating a Cpf instance', () {
      Cpf cpf = Cpf(code: 123456789);
      expect(cpf.code, equals(123456789));
      expect(cpf.checksum, equals(9));
      expect(cpf.format(), equals('123.456.789-09'));
      expect(cpf.toString(), equals('CPF 123.456.789-09'));
    });
  });

  group('Test Cpf() default constructor', () {
    test('CPF cannot have a code value lower than minimum lower limit', () {
      int value = Cpf.codeLowerLimit - 1;
      expect(() => Cpf(code: value), throwsA(isA<CpfCodeRangeError>()));
    });
    test('CPF cannot have a code value higher than maximum upper limit', () {
      int value = Cpf.codeUpperLimit + 1;
      expect(() => Cpf(code: value), throwsA(isA<CpfCodeRangeError>()));
    });
  });

  group('Test Cpf.fromString() constructor', () {
    test('Should throw if given digits did not match expected length', () {
      expect(() => Cpf.fromString('123.45'),
          throwsA(isA<InvalidCpfException>()));
    });
    test('Should throw if given CPF is improperly masked', () {
      expect(() => Cpf.fromString('123.456.789.09'),
          throwsA(isA<ImproperlyMaskedException>()));
    });
    test('Should throw if given CPF has invalid checksum digits', () {
      expect(() => Cpf.fromString('123.456.789-99'),
          throwsA(isA<InvalidChecksumException>()));
    });
    test('Should throw if given CPF is made up of same digit', () {
      expect(() => Cpf.fromString('000.000.000-00'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('111.111.111-11'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('222.222.222-22'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('333.333.333-33'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('444.444.444-44'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('555.555.555-55'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('666.666.666-66'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('777.777.777-77'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('888.888.888-88'),
          throwsA(isA<InvalidCpfException>()));
      expect(() => Cpf.fromString('999.999.999-99'),
          throwsA(isA<InvalidCpfException>()));
    });
  });
}
