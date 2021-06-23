A Dart library for validation of common document types used in Brazil to 
identify companies (CNPJ for legal persons) and individuals (CPF for physical 
persons) as well as other related stuff, such as brazilian states information.

## Usage

A simple usage example:

```dart
import 'package:br/br.dart';

main() {
  var cnpj = Cnpj.fromString('00.000.000/0001-91');
  var cpf = Cpf.fromString('123.456.789-09');

  print('This company is ${cnpj.isBranch() ? 'the head office' : 'a branch'}!');
  print('VP company CPF is ${cpf.format()}');
  print('"SP" is the State of ${getState('SP').name}');
}
```

See `example/` folder for more.
