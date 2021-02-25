class RegisterAuthException implements Exception {
  final _message;
  final _prefix;

  RegisterAuthException([
    this._message,
    this._prefix,
  ]);

  String toString() {
    return '$_prefix $_message';
  }
}

class RegisterDataException extends RegisterAuthException {
  RegisterDataException([String message]) : super(message, 'Invalid Credentials');
}
