import 'package:br/br.dart';

void main() {
  State state = getState('SP');
  print(state.label);
  print('Abbreviation: ${state.abbr}');
  print('Name        : ${state.name}');
  print('Region      : ${state.region.label}');
  print('toString()  : ${state.toString()}');
  print('Validation  : ${isState(state.abbr) ? 'Valid' : 'Not Valid'}');
}
