import 'package:get_storage/get_storage.dart';

enum StoreKeys {
  loginToken("login_token"),
  user("user");

  const StoreKeys(this.value);
  final String value;
}

class Store {
  static final _store = GetStorage();

  static get(StoreKeys key) => _store.read(key.value);
  static set(StoreKeys key, dynamic value) => _store.write(key.value, value);
  static remove(StoreKeys key) => _store.remove(key.value);
}