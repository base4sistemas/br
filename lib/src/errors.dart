// Copyright 2021 Base4 Sistemas
//
// Hierarchy:
//
//     ArgumentError
//         CnpjRootRangeError
//         CnpjBranchRangeError
//         CpfCodeRangeError
//

/// Thrown when a given CNPJ root argument is out of range.
class CnpjRootRangeError extends ArgumentError {
  CnpjRootRangeError(String message) : super(message);
}

/// Thrown when a given CNPJ branch argument is out of range.
class CnpjBranchRangeError extends ArgumentError {
  CnpjBranchRangeError(String message) : super(message);
}

/// Thrown when a given CPF code argument is out of range.
class CpfCodeRangeError extends ArgumentError {
  CpfCodeRangeError(String message) : super(message);
}
