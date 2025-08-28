import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:universal_web/web.dart' as web;

const _prefsKey = 'jaspr_serverpod_authentication_key';

class JasprAuthenticationKeyManager extends AuthenticationKeyManager {
  bool _initialized = false;
  String? _authenticationKey;
  final String runMode;
  final Storage _localStorage;
  final Storage _sessionStorage;

  JasprAuthenticationKeyManager({
    this.runMode = 'production',
  })  : _localStorage = WebStorage(useSessionStorage: false),
        _sessionStorage = WebStorage(useSessionStorage: true);

  @override
  Future<String?> get() async {
    if (!_initialized) {
      _authenticationKey = _sessionStorage.getString('${_prefsKey}_$runMode');
      _authenticationKey ??= _localStorage.getString('${_prefsKey}_$runMode');
      _initialized = true;
    }

    return _authenticationKey;
  }

  @override
  Future<void> put(String key, [bool useSessionStorage = true]) async {
    _authenticationKey = key;

    if (useSessionStorage) {
      _sessionStorage.setString('${_prefsKey}_$runMode', key);
    } else {
      _localStorage.setString('${_prefsKey}_$runMode', key);
    }
  }

  @override
  Future<void> remove() async {
    _authenticationKey = null;

    _localStorage.remove('${_prefsKey}_$runMode');
    _sessionStorage.remove('${_prefsKey}_$runMode');
  }
}

abstract class Storage {
  /// Stores an int value with the specified key.
  void setInt(String key, int value);

  /// Retrieves an int value with the specified key.
  int? getInt(String key);

  /// Stores a string value with the specified key.
  void setString(String key, String value);

  /// Retrieves a string value with the specified key.
  String? getString(String key);

  /// Removes a value for the specified key.
  void remove(String key);
}

class WebStorage extends Storage {
  final bool _useSessionStorage;

  WebStorage({required bool useSessionStorage})
      : _useSessionStorage = useSessionStorage;

  web.Storage get _getStorage =>
      _useSessionStorage ? web.window.sessionStorage : web.window.localStorage;

  @override
  int? getInt(String key) {
    final value = _getStorage.getItem(key);

    if (value == null) return null;

    return int.tryParse(value);
  }

  @override
  String? getString(String key) {
    return _getStorage.getItem(key);
  }

  @override
  void remove(String key) {
    _getStorage.removeItem(key);
  }

  @override
  void setInt(String key, int value) {
    _getStorage.setItem(key, value.toString());
  }

  @override
  void setString(String key, String value) {
    _getStorage.setItem(key, value);
  }
}
