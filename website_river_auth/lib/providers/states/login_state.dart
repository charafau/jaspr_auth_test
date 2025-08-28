// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

class LoginNotifierState {
  bool isLoggedIn;
  UserInfo? userInfo;
  LoginNotifierState({
    required this.isLoggedIn,
    this.userInfo,
  });

  LoginNotifierState copyWith({
    bool? isLoggedIn,
    UserInfo? userInfo,
  }) {
    return LoginNotifierState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  String toString() =>
      'LoginNotifierState(isLoggedIn: $isLoggedIn, userInfo: $userInfo)';

  @override
  bool operator ==(covariant LoginNotifierState other) {
    if (identical(this, other)) return true;

    return other.isLoggedIn == isLoggedIn && other.userInfo == userInfo;
  }

  @override
  int get hashCode => isLoggedIn.hashCode ^ userInfo.hashCode;
}
