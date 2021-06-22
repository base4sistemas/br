// TODO: Put public facing types in this file.

import './errors.dart';
import './exceptions.dart';
import './utils.dart';

/// Represents a CNPJ document, a number for identification of
/// companies (legal persons) established in Brazil.
class Cnpj {
  static const int rootLength = 8;
  static const int rootLowerLimit = 0;
  static const int rootUpperLimit = 99999999;
  static const int branchLength = 4;
  static const int branchLowerLimit = 1;
  static const int branchUpperLimit = 9999;
  static const int checksumLength = 2;
  static const int checksumLowerLimit = 0;
  static const int checksumUpperLimit = 99;
  static const int validLength = (rootLength + branchLength + checksumLength);
  static RegExp mask = RegExp(r'\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}');

  int root = 0;
  int branch = 0;
  int checksum = 0;

  Cnpj({required this.root, this.branch = branchLowerLimit}) {
    if (root < rootLowerLimit || root > rootUpperLimit) {
      throw CnpjRootRangeError(
          'CNPJ root value cannot be less than $rootLowerLimit '
          'nor greater than $rootUpperLimit; got: $root');
    } else if (branch < branchLowerLimit || branch > branchUpperLimit) {
      throw CnpjBranchRangeError('CNPJ branch value cannot be '
          'less than $branchLowerLimit (default) '
          'nor greater than $branchUpperLimit; got: $branch');
    }
    computeChecksum();
  }

  Cnpj.fromString(String cnpj) {
    String digits = digitsOf(cnpj);
    if (digits.length != validLength) {
      throw InvalidCnpjException(
        'CNPJ document number must have exactly $validLength '
        'numeric digits; got: $cnpj (${digits.length} digits)',
        cnpj,
      );
    }
    // since length of digits is OK, we need to test for a
    // valid masked CNPJ number if it's the case
    if (digits != cnpj) {
      if (!mask.hasMatch(cnpj)) {
        throw ImproperlyMaskedException(
          'CNPJ document has wrong format; '
          'pass in only digits or a proper masked document number '
          '(for example "00.000.000/0001-91"); got $cnpj',
          cnpj,
        );
      }
    }
    if (digits == (digits[0] * validLength)) {
      throw InvalidCnpjException(
        'CNPJ document number cannot be made entirely of '
        'the same numeric digit; got: $cnpj',
        cnpj,
      );
    }
    root = int.parse(digits.substring(0, 8));
    branch = int.parse(digits.substring(8, 12));
    computeChecksum();
    if (checksum != int.parse(digits.substring(12))) {
      throw InvalidChecksumException('CNPJ document is invalid: $cnpj', cnpj);
    }
  }

  void computeChecksum() {
    String digits = (root.toString().padLeft(rootLength, '0') +
        branch.toString().padLeft(branchLength, '0'));
    List<int> multipliers = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> payload =
        List.generate(digits.length, (index) => int.parse(digits[index]));

    for (int step = 1; step <= 2; step++) {
      int sum = 0;
      for (int i = 0; i < payload.length; i++) {
        sum += payload[i] * multipliers[i];
      }
      int result = 11 - (sum % 11);
      payload.add(result >= 10 ? 0 : result);
      multipliers.insert(0, 6);
    }

    checksum = (payload[12] * 10) + payload[13];
  }

  bool isBranch() => branch > 1;

  String format() {
    String digits = (root.toString().padLeft(rootLength, '0') +
        branch.toString().padLeft(branchLength, '0') +
        checksum.toString().padLeft(checksumLength, '0'));
    return (digits.substring(0, 2) +
        '.' +
        digits.substring(2, 5) +
        '.' +
        digits.substring(5, 8) +
        '/' +
        digits.substring(8, 12) +
        '-' +
        digits.substring(12));
  }

  @override
  String toString() {
    return 'CNPJ ${format()}';
  }
}

bool isCnpj(String cnpj) {
  try {
    Cnpj.fromString(cnpj);
    return true;
  } catch (e) {
    return false;
  }
}
