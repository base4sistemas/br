import 'package:br/br.dart';

void main() {
  // Following examples shows how to create a Cnpj instance using
  // root and branch (or head office) numbers.

  // CNPJ of Base4 Sistemas EIRELI
  // expected output: "CNPJ 08.427.847/0001-69"
  print(Cnpj(root: 8427847).toString());

  // CNPJ of Banco do Brasil, head office
  // expected output: "CNPJ 00.000.000/0001-91"
  print(Cnpj(root: 0).toString());

  // CNPJ of Banco do Brasil, branch 4248, Brasilia (DF), Asa Norte
  // expected output: "CNPJ 00.000.000/4248-03"
  print(Cnpj(root: 0, branch: 4248).toString());

  // Following examples shows how to create same Cnpj instances
  // from strings containing masked numbers or digits only.

  var cnpj = Cnpj.fromString('08.427.847/0001-69');
  print('Document: $cnpj, branch? ${cnpj.isBranch() ? 'yes' : 'no'}');
  print('root: ${cnpj.root}');
  print('branch: ${cnpj.branch}');
  print('checksum: ${cnpj.checksum}');
}
