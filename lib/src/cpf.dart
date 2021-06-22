import './errors.dart';
import './exceptions.dart';
import './utils.dart';

/// Represents a CPF document, a number for identification of
/// registration of individuals (physical persons) in Brazil.
class Cpf {
  static const int codeLength = 9;
  static const int codeLowerLimit = 1;
  static const int codeUpperLimit = 999999998;
  static const int checksumLength = 2;
  static const int checksumLowerLimit = 0;
  static const int checksumUpperLimit = 99;
  static const int validLength = (codeLength + checksumLength);
  static RegExp mask = RegExp(r'\d{3}\.\d{3}\.\d{3}\-\d{2}');

  int code = 0;
  int checksum = 0;

  Cpf({required this.code}) {
    if (code < codeLowerLimit || code > codeUpperLimit) {
      throw CpfCodeRangeError(
          'CPF code value cannot be less than $codeLowerLimit '
          'nor greater than $codeUpperLimit; got: $code');
    }
    computeChecksum();
  }

  Cpf.fromString(String cpf) {
    String digits = digitsOf(cpf);
    if (digits.length != validLength) {
      throw InvalidCpfException(
        'CPF document number must have exactly $validLength '
        'numeric digits; got: $cpf (${digits.length} digits)',
        cpf,
      );
    }
    // since length of digits is OK, we need to test for a
    // valid masked CPF number if it's the case
    if (digits != cpf) {
      if (!mask.hasMatch(cpf)) {
        throw ImproperlyMaskedException(
          'CPF document has wrong format; '
          'pass in only digits or a proper masked document number '
          '(for example "000.000.001-91"); got $cpf',
          cpf,
        );
      }
    }
    if (digits == (digits[0] * validLength)) {
      throw InvalidCpfException(
        'CPF document number cannot be made entirely of '
        'the same numeric digit; got: $cpf',
        cpf,
      );
    }
    code = int.parse(digits.substring(0, 9));
    computeChecksum();
    if (checksum != int.parse(digits.substring(9))) {
      throw InvalidChecksumException('CPF document is invalid: $cpf', cpf);
    }
  }

  void computeChecksum() {
    String digits = code.toString().padLeft(codeLength, '0');
    List<int> multipliers = [10, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> payload =
        List.generate(digits.length, (index) => int.parse(digits[index]));

    for (int step = 1; step <= 2; step++) {
      int sum = 0;
      for (int i = 0; i < payload.length; i++) {
        sum += payload[i] * multipliers[i];
      }
      int result = 11 - (sum % 11);
      payload.add(result >= 10 ? 0 : result);
      multipliers.insert(0, 11);
    }

    checksum = (payload[9] * 10) + payload[10];
  }

  String format() {
    String digits = (code.toString().padLeft(codeLength, '0') +
        checksum.toString().padLeft(checksumLength, '0'));
    return (digits.substring(0, 3) +
        '.' +
        digits.substring(3, 6) +
        '.' +
        digits.substring(6, 9) +
        '-' +
        digits.substring(9));
  }

  @override
  String toString() {
    return 'CPF ${format()}';
  }
}

bool isCpf(String cpf) {
  try {
    Cpf.fromString(cpf);
    return true;
  } catch (e) {
    return false;
  }
}
