import 'package:localstorage/localstorage.dart';

class CartStorage {
  final LocalStorage storage = LocalStorage('cart');
  void addToCart(value) {
    storage.setItem('cart', value);
  }
  getCart() {
    return storage.getItem('cart');
  }
}
