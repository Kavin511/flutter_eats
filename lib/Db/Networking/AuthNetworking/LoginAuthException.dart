class LoginAuthException implements Exception {
  final _message;
  final _prefix;

  LoginAuthException([
    this._message,
    this._prefix,
  ]);

  String toString() {
    return '$_prefix $_message';
  }
}

class LoginDataException extends LoginAuthException {
  LoginDataException([String message]) : super(message, 'InvalidCredentials');
}
