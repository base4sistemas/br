// Copyright 2021 Base4 Sistemas
//
// Hierarchy:
//
//     FormatException
//         InvalidDocumentException
//             InvalidChecksumException
//             ImproperlyMaskedException
//             InvalidCnpjException
//             InvalidCpfException
//

/// Thrown when a given document has wrong format
class InvalidDocumentException extends FormatException {
  InvalidDocumentException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given document has invalid checksum.
class InvalidChecksumException extends InvalidDocumentException {
  InvalidChecksumException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given document is improperly masked.
class ImproperlyMaskedException extends InvalidDocumentException {
  ImproperlyMaskedException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given CNPJ document is not valid.
class InvalidCnpjException extends InvalidDocumentException {
  InvalidCnpjException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given CPF document is not valid.
class InvalidCpfException extends InvalidDocumentException {
  InvalidCpfException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}
