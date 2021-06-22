// Copyright 2021 Base4 Sistemas
//
// Hierarchy:
//
//     FormatException
//         InvalidDocumentException
//             InvalidCnpjException
//             InvalidChecksumException
//             ImproperlyMaskedException
//

/// Thrown when a given document has wrong format
class InvalidDocumentException extends FormatException {
  InvalidDocumentException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given CNPJ document is not valid.
class InvalidCnpjException extends InvalidDocumentException {
  InvalidCnpjException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given CNPJ document has invalid checksum.
class InvalidChecksumException extends InvalidCnpjException {
  InvalidChecksumException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}

/// Thrown when a given CNPJ document is improperly masked.
class ImproperlyMaskedException extends InvalidCnpjException {
  ImproperlyMaskedException([String message = "", dynamic source, int? offset])
      : super(message, source, offset);
}
