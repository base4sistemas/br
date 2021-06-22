import 'package:br/br.dart';
import 'package:br/src/errors.dart';
import 'package:br/src/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('Test valid CNPJ numbers', () {
    test('Actual valid CNPJ number for Base4 Sistemas', () {
      expect(isCnpj('08.427.847/0001-69'), isTrue);
      expect(isCnpj('08427847000169'), isTrue);
    });
    test('Actual CNPJ for Banco do Brasil S/A (head office)', () {
      expect(isCnpj('00.000.000/0001-91'), isTrue);
      expect(isCnpj('00000000000191'), isTrue);
    });
    test('Actual CNPJ for Banco do Brasil S/A, Brasilia (DF) Asa Norte', () {
      expect(isCnpj('00.000.000/4248-03'), isTrue);
      expect(isCnpj('00000000424803'), isTrue);
    });
  });

  group('Test invalid CNPJ numbers', () {
    test('A CNPJ cannot be made entirely of the same digit', () {
      expect(isCnpj('00.000.000/0000-00'), isFalse);
      expect(isCnpj('11.111.111/1111-11'), isFalse);
      expect(isCnpj('22.222.222/2222-22'), isFalse);
      expect(isCnpj('33.333.333/3333-33'), isFalse);
      expect(isCnpj('44.444.444/4444-44'), isFalse);
      expect(isCnpj('55.555.555/5555-55'), isFalse);
      expect(isCnpj('66.666.666/6666-66'), isFalse);
      expect(isCnpj('77.777.777/7777-77'), isFalse);
      expect(isCnpj('88.888.888/8888-88'), isFalse);
      expect(isCnpj('99.999.999/9999-99'), isFalse);
    });
    test('A slightly different version of valid CNPJ', () {
      // changed last checksum digit
      expect(isCnpj('08.427.847/0001-68'), isFalse);
    });
    test('Improper CNPJ mask', () {
      // although the number is valid, it's improperly masked
      expect(isCnpj('08.427.847.0001.69'), isFalse);
      expect(isCnpj('08.427.847/0001.69'), isFalse);
      expect(isCnpj('.08427847000169'), isFalse);
    });
  });

  group('Test Cnpj class', () {
    test('Creating a Cnpj instance', () {
      Cnpj cnpj = Cnpj(root: 8427847);
      expect(cnpj.root, equals(8427847));
      expect(cnpj.branch, equals(1));
      expect(cnpj.checksum, equals(69));
      expect(cnpj.isBranch(), isFalse);
      expect(cnpj.format(), equals('08.427.847/0001-69'));
      expect(cnpj.toString(), equals('CNPJ 08.427.847/0001-69'));
    });

    test('Creating a Cnpj instance for a fictional document root', () {
      Cnpj cnpj = Cnpj(root: 123, branch: 2);
      expect(cnpj.root, equals(123));
      expect(cnpj.branch, equals(2));
      expect(cnpj.checksum, equals(3));
      expect(cnpj.isBranch(), isTrue);
      expect(cnpj.format(), equals('00.000.123/0002-03'));
      expect(cnpj.toString(), equals('CNPJ 00.000.123/0002-03'));
    });
  });

  group('Test Cnpj() default constructor', () {
    test('CNPJ cannot have a root value lower than minimum lower limit', () {
      int value = Cnpj.rootLowerLimit - 1;
      expect(() => Cnpj(root: value), throwsA(isA<CnpjRootRangeError>()));
    });
    test('CNPJ cannot have a root value higher than maximum upper limit', () {
      int value = Cnpj.rootUpperLimit + 1;
      expect(() => Cnpj(root: value), throwsA(isA<CnpjRootRangeError>()));
    });
    test('CNPJ cannot have a branch value lower than minimum lower limit', () {
      int value = Cnpj.branchLowerLimit - 1;
      expect(() => Cnpj(root: 1, branch: value),
          throwsA(isA<CnpjBranchRangeError>()));
    });
    test('CNPJ cannot have a branch value higher than maximum upper limit', () {
      int value = Cnpj.branchUpperLimit + 1;
      expect(() => Cnpj(root: 1, branch: value),
          throwsA(isA<CnpjBranchRangeError>()));
    });
  });

  group('Test Cnpj.fromString() constructor', () {
    test('Should throw if given digits did not match expected length', () {
      expect(() => Cnpj.fromString('08.427'),
          throwsA(isA<InvalidCnpjException>()));
    });
    test('Should throw if given CNPJ is improperly masked', () {
      expect(() => Cnpj.fromString('08.427.847.0001.69'),
          throwsA(isA<ImproperlyMaskedException>()));
    });
    test('Should throw if given CNPJ has invalid checksum digits', () {
      expect(() => Cnpj.fromString('08.427.847/0001-68'),
          throwsA(isA<InvalidChecksumException>()));
    });
    test('Should throw if given CNPJ is made up of same digit', () {
      expect(() => Cnpj.fromString('00.000.000/0000-00'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('11.111.111/1111-11'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('22.222.222/2222-22'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('33.333.333/3333-33'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('44.444.444/4444-44'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('55.555.555/5555-55'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('66.666.666/6666-66'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('77.777.777/7777-77'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('88.888.888/8888-88'),
          throwsA(isA<InvalidCnpjException>()));
      expect(() => Cnpj.fromString('99.999.999/9999-99'),
          throwsA(isA<InvalidCnpjException>()));
    });
  });
}
