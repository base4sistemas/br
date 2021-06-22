A library for validation of common document types used in Brazil to identify
companies (CNPJ for legal persons) and individuals (CPF for physical persons).

## Usage

A simple usage example:

```dart
import 'package:br/br.dart';

main() {
  var cnpj = Cnpj.fromString('00.000.000/0001-91');
  print('This company is ${cnpj.isBranch() ? 'the head office' : 'a branch'}!');
}
```
