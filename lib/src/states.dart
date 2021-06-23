/// Represents a single State region of Brazil.
class StateRegion {
  /// One or two letter abbreviation of region.
  final String abbr;

  /// State region name.
  final String name;

  const StateRegion({required String this.abbr, required String this.name});

  String get label => '$name ($abbr)';

  @override
  int get hashCode => abbr.hashCode ^ name.hashCode;

  @override
  bool operator ==(other) {
    return other is StateRegion && other.abbr == abbr && other.name == name;
  }

  @override
  String toString() {
    return 'StateRegion(abbr: "$abbr", name: "$name")';
  }
}

/// Represents a single State of Brazil.
class State {
  /// Two letter code abbreviation.
  final String abbr;

  /// State name.
  final String name;

  /// State IBGE code.
  final int ibge;

  /// State region.
  final StateRegion region;

  const State(
      {required String this.abbr,
      required String this.name,
      required int this.ibge,
      required StateRegion this.region});

  String get label => '$name ($abbr)';

  @override
  int get hashCode =>
      abbr.hashCode ^ name.hashCode ^ ibge.hashCode ^ region.hashCode;

  @override
  bool operator ==(other) {
    return other is State &&
        other.abbr == abbr &&
        other.name == name &&
        other.ibge == ibge &&
        other.region == region;
  }

  @override
  String toString() {
    return 'State(abbr: "$abbr", name: "$name", ibge: $ibge, region: $region)';
  }
}

const StateRegion north = StateRegion(abbr: 'N', name: 'Norte');
const StateRegion northEast = StateRegion(abbr: 'NE', name: 'Nordeste');
const StateRegion southEast = StateRegion(abbr: 'SE', name: 'Sudeste');
const StateRegion centerWest = StateRegion(abbr: 'CO', name: 'Centro-Oeste');
const StateRegion south = StateRegion(abbr: 'S', name: 'Sul');

const Map<String, State> statesOfBrazil = {
  // north region
  'AC': State(abbr: 'AC', name: 'Acre', ibge: 12, region: north),
  'AM': State(abbr: 'AM', name: 'Amazonas', ibge: 13, region: north),
  'AP': State(abbr: 'AP', name: 'Amapá', ibge: 16, region: north),
  'PA': State(abbr: 'PA', name: 'Pará', ibge: 15, region: north),
  'RR': State(abbr: 'RR', name: 'Roraima', ibge: 14, region: north),
  'RO': State(abbr: 'RO', name: 'Rondônio', ibge: 11, region: north),
  'TO': State(abbr: 'TO', name: 'Tocantins', ibge: 17, region: north),

  // north east region
  'AL': State(abbr: 'AL', name: 'Alagoas', ibge: 27, region: northEast),
  'BA': State(abbr: 'BA', name: 'Bahia', ibge: 29, region: northEast),
  'CE': State(abbr: 'CE', name: 'Ceará', ibge: 23, region: northEast),
  'MA': State(abbr: 'MA', name: 'Maranhão', ibge: 21, region: northEast),
  'PB': State(abbr: 'PB', name: 'Paraíba', ibge: 25, region: northEast),
  'PE': State(abbr: 'PE', name: 'Pernambuco', ibge: 26, region: northEast),
  'PI': State(abbr: 'PI', name: 'Piauí', ibge: 22, region: northEast),
  'SE': State(abbr: 'SE', name: 'Sergipe', ibge: 28, region: northEast),
  'RN': State(
      abbr: 'RN', name: 'Rio Grande do Norte', ibge: 24, region: northEast),

  // center west region
  'DF':
      State(abbr: 'DF', name: 'Distrito Federal', ibge: 53, region: centerWest),
  'GO': State(abbr: 'GO', name: 'Goiás', ibge: 52, region: centerWest),
  'MT': State(abbr: 'MT', name: 'Mato Grosso', ibge: 51, region: centerWest),
  'MS': State(
      abbr: 'MS', name: 'Mato Grosso do Sul', ibge: 50, region: centerWest),

  // south east region
  'ES': State(abbr: 'ES', name: 'Espírito Santo', ibge: 32, region: southEast),
  'MG': State(abbr: 'MG', name: 'Minas Gerais', ibge: 31, region: southEast),
  'RJ': State(abbr: 'RJ', name: 'Rio de Janeiro', ibge: 33, region: southEast),
  'SP': State(abbr: 'SP', name: 'São Paulo', ibge: 35, region: southEast),

  // south region
  'PR': State(abbr: 'PR', name: 'Paraná', ibge: 41, region: south),
  'RS': State(abbr: 'RS', name: 'Rio Grande do Sul', ibge: 43, region: south),
  'SC': State(abbr: 'SC', name: 'Santa Catarina', ibge: 42, region: south),
};

/// Validate State abbreviation.
bool isState(String abbr) {
  return statesOfBrazil.containsKey(abbr);
}

/// Return a State instance by its abbreviation.
State getState(String abbr) {
  State? state = statesOfBrazil[abbr];
  if (state == null) {
    throw ArgumentError('Unknown State abbreviation: $abbr');
  }
  return state;
}
