// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterNotifierState {
  bool hasPasswordError;
  bool hasPasswordRepeatError;
  bool hasEmailError;
  bool hasUsernameError;

  String username;
  String email;
  String password;
  String passwordRepeat;

  RegisterNotifierState({
    this.hasPasswordError = false,
    this.hasPasswordRepeatError = false,
    this.hasEmailError = false,
    this.hasUsernameError = false,
    this.username = '',
    this.email = '',
    this.password = '',
    this.passwordRepeat = '',
  });

  RegisterNotifierState copyWith({
    bool? hasPasswordError,
    bool? hasPasswordRepeatError,
    bool? hasEmailError,
    bool? hasUsernameError,
    String? username,
    String? email,
    String? password,
    String? passwordRepeat,
  }) {
    return RegisterNotifierState(
      hasPasswordError: hasPasswordError ?? this.hasPasswordError,
      hasPasswordRepeatError:
          hasPasswordRepeatError ?? this.hasPasswordRepeatError,
      hasEmailError: hasEmailError ?? this.hasEmailError,
      hasUsernameError: hasUsernameError ?? this.hasUsernameError,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hasPasswordError': hasPasswordError,
      'hasPasswordRepeatError': hasPasswordRepeatError,
      'hasEmailError': hasEmailError,
      'hasUsernameError': hasUsernameError,
      'username': username,
      'email': email,
      'password': password,
      'passwordRepeat': passwordRepeat,
    };
  }

  factory RegisterNotifierState.fromMap(Map<String, dynamic> map) {
    return RegisterNotifierState(
      hasPasswordError: map['hasPasswordError'] as bool,
      hasPasswordRepeatError: map['hasPasswordRepeatError'] as bool,
      hasEmailError: map['hasEmailError'] as bool,
      hasUsernameError: map['hasUsernameError'] as bool,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      passwordRepeat: map['passwordRepeat'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterNotifierState.fromJson(String source) =>
      RegisterNotifierState.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterNotifierState(hasPasswordError: $hasPasswordError, hasPasswordRepeatError: $hasPasswordRepeatError, hasEmailError: $hasEmailError, hasUsernameError: $hasUsernameError, username: $username, email: $email, password: $password, passwordRepeat: $passwordRepeat)';
  }

  @override
  bool operator ==(covariant RegisterNotifierState other) {
    if (identical(this, other)) return true;

    return other.hasPasswordError == hasPasswordError &&
        other.hasPasswordRepeatError == hasPasswordRepeatError &&
        other.hasEmailError == hasEmailError &&
        other.hasUsernameError == hasUsernameError &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.passwordRepeat == passwordRepeat;
  }

  @override
  int get hashCode {
    return hasPasswordError.hashCode ^
        hasPasswordRepeatError.hashCode ^
        hasEmailError.hashCode ^
        hasUsernameError.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        passwordRepeat.hashCode;
  }
}
