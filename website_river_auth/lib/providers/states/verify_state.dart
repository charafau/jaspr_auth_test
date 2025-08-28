// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerifyNotifierState {
  bool hasVerifyError;
  bool hasEmailError;
  String verify;
  String email;

  VerifyNotifierState({
    this.hasVerifyError = false,
    this.hasEmailError = false,
    this.verify = '',
    this.email = '',
  });

  VerifyNotifierState copyWith({
    bool? hasVerifyError,
    bool? hasEmailError,
    String? verify,
    String? email,
  }) {
    return VerifyNotifierState(
      hasVerifyError: hasVerifyError ?? this.hasVerifyError,
      hasEmailError: hasEmailError ?? this.hasEmailError,
      verify: verify ?? this.verify,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hasVerifyError': hasVerifyError,
      'hasEmailError': hasEmailError,
      'verify': verify,
      'email': email,
    };
  }

  factory VerifyNotifierState.fromMap(Map<String, dynamic> map) {
    return VerifyNotifierState(
      hasVerifyError: map['hasVerifyError'] as bool,
      hasEmailError: map['hasEmailError'] as bool,
      verify: map['verify'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyNotifierState.fromJson(String source) =>
      VerifyNotifierState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VerifyNotifierState(hasVerifyError: $hasVerifyError, hasEmailError: $hasEmailError, verify: $verify, email: $email)';
  }

  @override
  bool operator ==(covariant VerifyNotifierState other) {
    if (identical(this, other)) return true;

    return other.hasVerifyError == hasVerifyError &&
        other.hasEmailError == hasEmailError &&
        other.verify == verify &&
        other.email == email;
  }

  @override
  int get hashCode {
    return hasVerifyError.hashCode ^
        hasEmailError.hashCode ^
        verify.hashCode ^
        email.hashCode;
  }
}
