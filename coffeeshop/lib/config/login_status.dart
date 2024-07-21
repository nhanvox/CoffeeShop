class LoginStatus {
  static final LoginStatus _instance = LoginStatus._internal();

  bool loggedIn = false;
  String? userID;

  LoginStatus._internal();

  static LoginStatus get instance => _instance;
}
