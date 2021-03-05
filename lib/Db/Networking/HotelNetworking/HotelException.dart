class HotelException implements Exception {
  final _message;
  final _prefix;
  HotelException([
    this._message,
    this._prefix
  ]);

  String toString() {
    return '$_prefix $_message';
  }
}

class HotelFetchDataException extends HotelException {
  HotelFetchDataException([String message])
      :super(message, 'Error during communication');
}

class HotelBadRequestException extends HotelException {
  HotelBadRequestException([String message]) :super(message, 'Bad request');
}
// class HotelFetchDataException extends HotelException{
//   HotelFetchDataException([String message]):super(message,'Error during communication');
// }
// class HotelFetchDataException extends HotelException{
//   HotelFetchDataException([String message]):super(message,'Error during communication');
// }