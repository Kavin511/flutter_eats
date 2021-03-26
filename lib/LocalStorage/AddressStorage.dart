import 'package:localstorage/localstorage.dart';

class AddressStorage {
  final LocalStorage storage = LocalStorage('address');
  void addAddress(value) {
    storage.setItem('address', value);
  }
  getAddress() {
    return storage.getItem('address');
  }
}
