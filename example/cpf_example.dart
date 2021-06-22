import 'package:br/br.dart';

void main() {
  // Following examples shows how to create a Cpf instance.
  // All CPF numbers here are fictional.

  // A CPF with lowest code value possible
  // expected output: "CPF 000.000.001-91"
  print(Cpf(code: 1).toString());

  // A CPF with highest code value possible
  // expected output: "CPF 999.999.998-08"
  print(Cpf(code: 999999998).toString());

  // A CPF with a sequential code value
  // expected output: "CPF 123.456.789-09"
  print(Cpf(code: 123456789).toString());

  // Following examples shows how to create a Cpf instance
  // from a string containing a valid masked CPF.

  var cpf = Cpf.fromString('123.456.789-09');
  print('Document: $cpf');
  print('code: ${cpf.code}');
  print('checksum: ${cpf.checksum}');

  // Following example show how to just validate CPF numbers
  // without the need to create Cpf instances.
  List<String> numbers = [
    '000.000.001-91',
    '999.999.998-08',
    '123.456.789-09',
    '123.456.789-10'
  ];
  for (String number in numbers) {
    print('CPF $number is ${isCpf(number) ? 'valid' : 'not valid'}!');
  }
}
