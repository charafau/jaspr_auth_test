import 'dart:convert';
import 'dart:typed_data';

import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:universal_web/web.dart' as web;
import 'package:website_river_auth/login/jaspr_authentication_key_manager.dart';

const _prefsKey = 'serverpod_userinfo_key';
const _prefsVersion = 2;

class JasprServerpodSessionManager extends ChangeNotifier {
  static JasprServerpodSessionManager? _instance;

  Caller caller;
  final Storage _localStorage;
  final Storage _sessionStorage;

  late JasprAuthenticationKeyManager keyManager;

  JasprServerpodSessionManager({
    required this.caller,
  })  : _localStorage = WebStorage(useSessionStorage: false),
        _sessionStorage = WebStorage(useSessionStorage: true) {
    _instance = this;
    keyManager =
        caller.client.authenticationKeyManager as JasprAuthenticationKeyManager;
  }

  /// Returns a singleton instance of the session manager
  static Future<JasprServerpodSessionManager> get instance async {
    assert(_instance != null,
        'You need to create a SessionManager before the instance method can be called');
    return _instance!;
  }

  UserInfo? _signedInUser;

  /// Returns information about the signed in user or null if no user is
  /// currently signed in.
  UserInfo? get signedInUser => _signedInUser;

  /// Registers the signed in user, updates the [keyManager], and upgrades the
  /// streaming connection if it is open.
  Future<void> registerSignedInUser(
    UserInfo userInfo,
    int authenticationKeyId,
    String authenticationKey, [
    bool useSessionStorage = true,
  ]) async {
    _signedInUser = userInfo;
    var key = '$authenticationKeyId:$authenticationKey';

    // Store in key manager.
    await keyManager.put(key, useSessionStorage);
    await _storeValues(useSessionStorage: useSessionStorage);

    // Update streaming connection, if it's open.
    await caller.client.updateStreamingConnectionAuthenticationKey(key);
    notifyListeners();
  }

  /// Returns true if the user is currently signed in.
  bool get isSignedIn => signedInUser != null;

  /// Initializes the session manager by reading the current state from
  /// shared preferences. The returned bool is true if the session was
  /// initialized, or false if the server could not be reached.
  Future<bool> initialize() async {
    await _loadValues();
    return refreshSession();
  }

  /// Signs the user out from their devices.
  /// If [allDevices] is true, signs out from all devices; otherwise, signs out from the current device only.
  /// Returns true if the sign-out is successful.
  Future<bool> _signOut({
    required bool allDevices,
  }) async {
    if (!isSignedIn) return true;

    try {
      if (allDevices) {
        await caller.status.signOutAllDevices();
      } else {
        await caller.status.signOutDevice();
      }
      await caller.client.updateStreamingConnectionAuthenticationKey(null);

      _signedInUser = null;
      await _storeValues(useSessionStorage: true);
      await _storeValues();
      await keyManager.remove();

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Signs the user out from all connected devices.
  /// Returns true if successful.
  Future<bool> signOutAllDevices() async {
    return _signOut(allDevices: true);
  }

  /// Signs the user out from the current device.
  /// Returns true if successful.
  Future<bool> signOutDevice() async {
    return _signOut(allDevices: false);
  }

  /// Verify the current sign in status with the server and update the UserInfo.
  /// Returns true if successful.
  Future<bool> refreshSession() async {
    try {
      _signedInUser = await caller.status.getUserInfo();
      await _storeValues();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _loadValues() async {
    var version =
        _localStorage.getInt('${_prefsKey}_${keyManager.runMode}_version');

    if (version != _prefsVersion) {
      version =
          _localStorage.getInt('${_prefsKey}_${keyManager.runMode}_version');
    }

    if (version != _prefsVersion) return;

    var json = _sessionStorage.getString('${_prefsKey}_${keyManager.runMode}');

    json ??= _localStorage.getString('${_prefsKey}_${keyManager.runMode}');

    if (json == null) return;

    _signedInUser = Protocol().deserialize<UserInfo>(jsonDecode(json));

    notifyListeners();
  }

  Future<void> _storeValues({bool useSessionStorage = true}) async {
    if (useSessionStorage) {
      _sessionStorage.setInt(
          '${_prefsKey}_${keyManager.runMode}_version', _prefsVersion);
      if (signedInUser == null) {
        _sessionStorage.remove('${_prefsKey}_${keyManager.runMode}');
      } else {
        _sessionStorage.setString('${_prefsKey}_${keyManager.runMode}',
            SerializationManager.encode(signedInUser));
      }
    } else {
      _localStorage.setInt(
          '${_prefsKey}_${keyManager.runMode}_version', _prefsVersion);
      if (signedInUser == null) {
        _localStorage.remove('${_prefsKey}_${keyManager.runMode}');
      } else {
        _localStorage.setString('${_prefsKey}_${keyManager.runMode}',
            SerializationManager.encode(signedInUser));
      }
    }
  }

  /// Uploads a new user image if the user is signed in. Returns true if upload
  /// was successful.
  Future<bool> uploadUserImage(ByteData image) async {
    if (_signedInUser == null) return false;

    try {
      var success = await caller.user.setUserImage(image);
      if (success) {
        _signedInUser = await caller.status.getUserInfo();

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
