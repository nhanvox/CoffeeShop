import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'login_status.dart';

class AuthService {
  // Check token and set login status at app startup
  static Future<void> checkAndSetLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && !JwtDecoder.isExpired(token)) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String? userID = decodedToken['_id'];

      LoginStatus.instance.loggedIn = true;
      LoginStatus.instance.userID = userID;
    } else {
      LoginStatus.instance.loggedIn = false;
      LoginStatus.instance.userID = null;
    }
  }
}
